
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
  region  = "us-central1"
}

# Reference the artifact registry for container images
data "google_artifact_registry_repository" "app" {
  location      = "us-central1"
  repository_id = "app"
}

# Create the service account for Cloud Run
module "cloud_run_sa" {
  source     = "../../modules/cloud-run-service-account"
  project_id = "launchflow-services-dev"
}

# Deploy the Cloud Run service
module "cloud_run_service" {
  source = "../../modules/cloud-run-service"

  project_id            = "launchflow-services-dev"
  location             = "us-central1"
  service_name         = "app-dev"
  container_image      = "${data.google_artifact_registry_repository.app.repository_url}/app:latest"
  service_account_email = module.cloud_run_sa.service_account_email
  bucket_name          = "app-storage-dev"
  
  environment_variables = {
    ENVIRONMENT = "development"
  }

  # Development environment scaling configuration
  min_instances = 0
  max_instances = 2
  cpu          = "1000m"
  memory       = "512Mi"

  allow_public_access = true
}

# Output the service URL
output "service_url" {
  description = "The URL of the deployed Cloud Run service"
  value       = module.cloud_run_service.service_url
}
