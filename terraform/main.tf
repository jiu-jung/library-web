provider "google" {
  project = var.project_id
  region  = var.region
}

# Artifact Registry
resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.region
  repository_id = var.repo_name
  format        = "DOCKER"
  description   = "Docker repository for Cloud Run"
}

# Service Account
resource "google_service_account" "cloud_run_sa" {
  account_id   = var.service_account_id
  display_name = "Cloud Run GitHub Deploy SA"
}

# IAM Roles
resource "google_project_iam_member" "cloud_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

resource "google_project_iam_member" "artifact_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

resource "google_project_iam_member" "sa_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

# Service Account Key (GitHub Actions에서 사용)
resource "google_service_account_key" "github_key" {
  service_account_id = google_service_account.cloud_run_sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
  private_key_type   = "TYPE_JSON"
}

# Cloud Run 서비스
resource "google_cloud_run_v2_service" "default" {
  name     = var.cloud_run_service_name
  location = var.region

  template {
    containers {
      image = var.docker_image_url
      ports {
        container_port = 8080
      }
    }

    service_account = google_service_account.cloud_run_sa.email
  }

  traffic {
    percent         = 100
    type            = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }

  lifecycle {
    ignore_changes = [template[0].containers[0].image]  # 이미지 재배포 막기
  }
}

# Cloud Run 공개 접근 허용
resource "google_cloud_run_v2_service_iam_member" "invoker" {
  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.default.name

  role   = "roles/run.invoker"
  member = "allUsers"
}
