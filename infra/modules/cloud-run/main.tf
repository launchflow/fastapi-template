
resource "google_service_account" "service_account" {
  account_id   = var.service_name
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

      env {
        name  = "PROJECT_ID"
        value = var.project_id
      }
    }

    service_account = google_service_account.service_account.email
  }
}

# IAM binding for public access (if enabled)
resource "google_cloud_run_v2_service_iam_member" "public" {
  count    = var.public_access ? 1 : 0
  project  = google_cloud_run_v2_service.service.project
  location = google_cloud_run_v2_service.service.location
  name     = google_cloud_run_v2_service.service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
