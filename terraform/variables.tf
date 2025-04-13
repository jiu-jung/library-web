variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "asia-northeast1"
}

variable "repo_name" {
  description = "Artifact Registry 이름"
  type        = string
  default     = "library-repo-01"
}

variable "service_account_id" {
  description = "Service Account ID"
  type        = string
  default     = "cloud-run-github-sa"
}

variable "cloud_run_service_name" {
  description = "Cloud Run 서비스 이름"
  type        = string
  default     = "library-app"
}

variable "docker_image_url" {
  description = "배포할 Docker 이미지 URL"
  type        = string
}
