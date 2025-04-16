
output "service_url" {
  description = "The URL of the deployed service"
  value       = google_cloud_run_v2_service.service.uri
}

output "service_id" {
  description = "The ID of the service"
  value       = google_cloud_run_v2_service.service.id
}

output "latest_ready_revision" {
  description = "The name of the latest ready revision"
  value       = google_cloud_run_v2_service.service.latest_ready_revision
}
