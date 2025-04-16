
output "service_url" {
  description = "The URL of the deployed service"
  value       = module.cloud_run.service_url
}

output "service_account_email" {
  description = "The email of the service account"
  value       = google_service_account.service_account.email
}

output "service_name" {
  description = "The name of the Cloud Run service"
  value       = module.cloud_run.service_name
}
