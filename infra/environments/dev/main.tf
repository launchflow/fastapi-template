
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
resource "google_service_account" "cloud_run_service_account" {
  account_id   = "cloud-run-service-account"
  display_name = "Cloud Run Service Account"
}

module "cloud_run" {
  source = "../../modules/cloud-run"

  project_id            = "launchflow-services-dev"
  location             = "us-west1"
  service_name         = "python-app-dev"
  image                = "us-west1-docker.pkg.dev/launchflow-services-dev/app/python-app:latest"
  service_account_email = google_service_account.cloud_run_service_account.email
}

output "service_url" {
  value = module.cloud_run.service_url
}

output "service_status" {
  value = module.cloud_run.service_status
}
