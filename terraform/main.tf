provider "google" {
  project = var.project_id
  region  = var.region
}

# Artifact Registry 생성
resource "google_artifact_registry_repository" "docker_repo" {
  location     = var.region
  repository_id = var.repo_name
  format       = "DOCKER"
}

# 서비스 계정 생성
resource "google_service_account" "cloud_run_sa" {
  account_id   = var.service_account_id
  display_name = "Cloud Run GitHub Deploy SA"
}

# 서비스 계정에 IAM 역할 부여
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

# 서비스 계정 키 생성
resource "google_service_account_key" "github_key" {
  service_account_id = google_service_account.cloud_run_sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
  private_key_type   = "TYPE_JSON"
}
