
output "repository_url" {
  description = "The URL of the artifact registry repository"
  value       = "${var.location}-docker.pkg.dev/${google_artifact_registry_repository.repository.project}/${google_artifact_registry_repository.repository.repository_id}"
}

output "repository_id" {
  description = "The ID of the artifact registry repository"
  value       = google_artifact_registry_repository.repository.repository_id
}
