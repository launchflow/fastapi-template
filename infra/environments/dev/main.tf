
terraform {
  backend "gcs" {
    bucket = "infra-new-state"
    prefix = "tanke/v3/dev"
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

module "cloud_run_service" {
  source = "../../modules/cloud-run"

  project_id   = "launchflow-services-dev"
  location     = "us-west1"
  service_name = "app-dev"
  image        = "us-west1-docker.pkg.dev/launchflow-services-dev/app/service:latest"
}

output "service_url" {
  description = "The URL of the deployed Cloud Run service"
  value       = module.cloud_run_service.service_url
}
