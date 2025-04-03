
output "service_url" {
  description = "The URL of the deployed service"
  value       = google_cloud_run_v2_service.service.uri
}

output "service_name" {
  description = "Name of the deployed service"
  value       = google_cloud_run_v2_service.service.name
}

output "service_location" {
  description = "Location of the deployed service"
  value       = google_cloud_run_v2_service.service.location
}
