
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

  # Configure service account
  service_account_email = var.service_account_email

  # Configure scaling
  template_annotations = {
    "autoscaling.knative.dev/maxScale" = "4"
    "autoscaling.knative.dev/minScale" = "1"
  }
}
