
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
  backend "gcs" {
    bucket = "infra-new-state"
    prefix = "dev"
  }
}

provider "google" {
  project = "launchflow-services-dev"
  region  = "us-west1"
}

# Service account for Cloud Run
resource "google_service_account" "cloud_run_sa" {
  account_id   = "cloud-run-service"
  display_name = "Cloud Run Service Account"
  description  = "Service account for Cloud Run service"
}

# Cloud Run service
module "cloud_run_service" {
  source = "./modules/cloud-run"

  project_id            = "launchflow-services-dev"
  location             = "us-west1"
  service_name         = "app"
  image                = "us-west1-docker.pkg.dev/launchflow-services-dev/app/service:latest"
  service_account_email = google_service_account.cloud_run_sa.email
}
