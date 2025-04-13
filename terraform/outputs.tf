output "cloud_run_url" {
  description = "배포된 Cloud Run 서비스 URL"
  value       = google_cloud_run_v2_service.default.uri
}

output "service_account_email" {
  description = "서비스 계정 이메일"
  value       = google_service_account.cloud_run_sa.email
}

output "service_account_key_json" {
  description = "GitHub Actions에서 사용할 서비스 계정 키"
  value       = google_service_account_key.github_key.private_key
  sensitive   = true
}
