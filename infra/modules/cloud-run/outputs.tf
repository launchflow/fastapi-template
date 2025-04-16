
output "service_url" {
  description = "The URL of the deployed service"
  value       = module.cloud_run.service_url
}

output "service_id" {
  description = "The ID of the deployed service"
  value       = module.cloud_run.service_id
}

output "service_status" {
  description = "The status of the deployed service"
  value       = module.cloud_run.service_status
}
