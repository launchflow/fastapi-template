
module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "0.17.0"

  # Required variables
  project_id   = var.project_id
  location     = var.location
  service_name = var.service_name
  image        = var.image

  # Make the service publicly accessible
  service_annotations = {
    "run.googleapis.com/ingress" = "all"
  }

  template_annotations = {
    "run.googleapis.com/client-name"   = "terraform"
    "generated-by"                     = "terraform"
    "autoscaling.knative.dev/maxScale" = "2"
    "autoscaling.knative.dev/minScale" = "1"
  }

  # Default port configuration
  ports = {
    name = "http1"
    port = 8080
  }
}

# Allow unauthenticated access to the service
resource "google_cloud_run_service_iam_member" "public_access" {
  location = module.cloud_run.location
  service  = module.cloud_run.service_name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
