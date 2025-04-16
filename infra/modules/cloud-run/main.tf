
module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "0.17.2"

  # Required variables
  project_id   = var.project_id
  location     = var.location
  service_name = var.service_name
  image        = var.image

  # Optional configurations
  service_account_email = var.service_account_email

  template_annotations = {
    "run.googleapis.com/client-name"   = "terraform"
    "generated-by"                     = "terraform"
    "autoscaling.knative.dev/maxScale" = "3"
    "autoscaling.knative.dev/minScale" = "1"
  }

  service_annotations = {
    "run.googleapis.com/ingress" = "all"
  }
}
