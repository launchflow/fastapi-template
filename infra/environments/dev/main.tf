
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

module "cloud_run" {
  source = "../../modules/cloud-run"

  project_id   = "launchflow-services-dev"
  location     = "us-west1"
  service_name = "app-dev"
  image        = "us-west1-docker.pkg.dev/launchflow-services-dev/app/service:latest"
}

output "service_url" {
  description = "The URL of the deployed service"
  value       = module.cloud_run.service_url
}

output "service_status" {
  description = "The status of the deployed service"
  value       = module.cloud_run.service_status
}
