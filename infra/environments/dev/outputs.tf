
output "service_url" {
  description = "The URL of the deployed service"
  value       = module.cloud_run.service_url
}

output "repository_url" {
  description = "The URL of the artifact registry repository"
  value       = module.artifact_registry.repository_url
}
