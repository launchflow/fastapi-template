
output "service_url" {
  description = "The URL of the deployed Cloud Run service"
  value       = module.cloud_run.service_url
}

output "service_status" {
  description = "The status of the Cloud Run service"
  value       = module.cloud_run.service_status
}
