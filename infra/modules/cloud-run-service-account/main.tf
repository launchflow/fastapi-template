
module "service_account" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "4.5.0"

  project_id = var.project_id
  names      = ["cloud-run-sa"]
  project_roles = [
    "${var.project_id}=>roles/run.invoker",
    "${var.project_id}=>roles/storage.objectViewer"
  ]
  display_name = "Cloud Run Service Account"
  description  = "Service account for Cloud Run service with GCS access"
}
