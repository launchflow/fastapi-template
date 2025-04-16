
output "service_url" {
  description = "The URL on which the deployed service is available"
  value       = module.cloud_run.service_url
}

output "location" {
  description = "Location in which the Cloud Run service was created"
  value       = module.cloud_run.location
}

output "service_name" {
  description = "Name of the created service"
  value       = module.cloud_run.service_name
}
