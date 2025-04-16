
terraform {
  backend "gcs" {
    bucket = "infra-new-state"
    prefix = "dev"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
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
module "cloud_run" {
  source = "../modules/cloud_run"

  project_id            = "launchflow-services-dev"
  location             = "us-west1"
  service_name         = "app-dev"
  image                = "us-west1-docker.pkg.dev/launchflow-services-dev/app/myapp:latest"
  service_account_email = google_service_account.cloud_run_sa.email
}
