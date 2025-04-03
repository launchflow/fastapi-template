
provider "google" {
  project = "launchflow-services-dev"
  region  = "us-west1"
}

resource "google_cloud_run_v2_service" "fastapi_service" {
  name     = "fastapi-app"
  location = "us-west1"

  template {
    containers {
      image = "gcr.io/launchflow-services-dev/fastapi-app:latest"
      
      ports {
        container_port = 80
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }

    scaling {
      min_instance_count = 0
      max_instance_count = 2
    }
  }

  # Allow unauthenticated access
  depends_on = [google_cloud_run_service_iam_member.public_access]
}

resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_v2_service.fastapi_service.location
  service  = google_cloud_run_v2_service.fastapi_service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Output the service URL
output "service_url" {
  value = google_cloud_run_v2_service.fastapi_service.uri
}
