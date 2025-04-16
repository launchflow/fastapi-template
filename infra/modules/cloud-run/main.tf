
module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "0.17.2"

  # Required variables
  project_id   = var.project_id
  location     = var.location
  service_name = var.service_name
  image        = var.image

  # Optional configurations
  service_account_email = google_service_account.service_account.email

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

# Create a service account for the Cloud Run service
resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = "${var.service_name}-sa"
  display_name = "Service Account for ${var.service_name} Cloud Run service"
}

# Grant the service account access to GCS
resource "google_project_iam_member" "gcs_access" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
