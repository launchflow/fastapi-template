
output "service_url" {
  description = "The URL of the deployed service"
  value       = module.cloud_run.service_url
}

output "location" {
  description = "The location of the deployed service"
  value       = module.cloud_run.location
}

output "service_name" {
  description = "The name of the deployed service"
  value       = module.cloud_run.service_name
}
