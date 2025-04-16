
terraform {
  backend "gcs" {
    bucket = "infra-new-state"
    prefix = "tanke/v3/python-app/dev"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {
  project = "launchflow-services-dev"
  region  = "us-west1"
}

# Create service account for Cloud Run
resource "google_service_account" "cloud_run_sa" {
  account_id   = "cloud-run-service"
  display_name = "Cloud Run Service Account"
  description  = "Service account for Cloud Run application"
}

# Use the Cloud Run module
module "cloud_run_service" {
  source = "../../modules/cloud-run"

  project_id            = "launchflow-services-dev"
  location             = "us-west1"
  service_name         = "python-app-dev"
  image                = "us-west1-docker.pkg.dev/launchflow-services-dev/app/python-app:latest"
  service_account_email = google_service_account.cloud_run_sa.email
}
