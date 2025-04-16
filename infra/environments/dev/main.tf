
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

# Reference the artifact registry for the image
data "google_artifact_registry_repository" "app" {
  location      = "us-west1"
  repository_id = "app"
}

module "cloud_run_service" {
  source = "../../modules/cloud-run"

  project_id   = "launchflow-services-dev"
  location     = "us-west1"
  service_name = "app-dev"
  image        = "${data.google_artifact_registry_repository.app.location}-docker.pkg.dev/${data.google_artifact_registry_repository.app.project}/${data.google_artifact_registry_repository.app.repository_id}/service:latest"
}

output "service_url" {
  description = "The URL of the deployed service"
  value       = module.cloud_run_service.service_url
}
