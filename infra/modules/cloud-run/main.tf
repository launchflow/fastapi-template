
module "cloud_run_service_account" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "4.5.3"
  project_id = var.project_id
  names      = ["cloud-run-service"]
  project_roles = [
    "${var.project_id}=>roles/run.invoker",
  ]
}

module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "0.17.2"

  project_id   = var.project_id
  location     = var.location
  service_name = var.service_name
  image        = var.image

  service_account_email = module.cloud_run_service_account.email

  template_annotations = {
    "run.googleapis.com/client-name"   = "terraform"
    "generated-by"                     = "terraform"
    "autoscaling.knative.dev/maxScale" = "4"
    "autoscaling.knative.dev/minScale" = "1"
  }

  service_annotations = {
    "run.googleapis.com/ingress" = "all"
  }
}
