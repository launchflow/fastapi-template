
output "service_url" {
  description = "The URL where the Cloud Run service is available"
  value       = module.cloud_run_service.service_url
}

output "service_status" {
  description = "The current status of the Cloud Run service"
  value       = module.cloud_run_service.service_status
}
