
provider "google" {
  project = "launchflow-services-dev"  # Change this to your production project ID
  region  = "us-west1"
}

resource "google_cloud_run_v2_service" "fastapi_service" {
  name     = "fastapi-app"
  location = "us-west1"

  template {
    containers {
      image = "gcr.io/launchflow-services-dev/fastapi-app:latest"  # Update with your production image
      
      ports {
        container_port = 80
      }

      resources {
        limits = {
          cpu    = "2"
          memory = "1Gi"
        }
      }
    }

    scaling {
      min_instance_count = 1  # Always have at least one instance running
      max_instance_count = 5  # Scale up to 5 instances
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
