
resource "google_service_account" "service_account" {
  account_id   = var.service_account_id
  display_name = "Service Account for ${var.service_name}"
  description  = "Service account for Cloud Run service ${var.service_name}"
}

resource "google_cloud_run_v2_service" "service" {
  name     = var.service_name
  location = var.location

  template {
    containers {
      image = var.container_image
      
      resources {
        limits = {
          cpu    = var.cpu
          memory = var.memory
        }
      }
    }

    service_account = google_service_account.service_account.email
  }
}

# IAM binding to allow unauthenticated access if enabled
resource "google_cloud_run_v2_service_iam_member" "public" {
  count    = var.allow_unauthenticated ? 1 : 0
  project  = google_cloud_run_v2_service.service.project
  location = google_cloud_run_v2_service.service.location
  name     = google_cloud_run_v2_service.service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
