
output "service_url" {
  description = "The URL on which the deployed service is available"
  value       = module.cloud_run.service_url
}

output "service_id" {
  description = "Unique identifier for the Cloud Run service"
  value       = module.cloud_run.service_id
}

output "service_status" {
  description = "Status of the Cloud Run service"
  value       = module.cloud_run.service_status
}
