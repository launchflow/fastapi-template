
terraform {
  backend "gcs" {
    bucket = "infra-new-state"
    prefix = "dev"
  }
}

provider "google" {
  project = "launchflow-services-dev"
  region  = "us-west1"
}

module "app" {
  source = "../../modules/cloud_run"

  service_name      = "app-dev"
  location         = "us-west1"
  service_account_id = "app-dev-sa"
  container_image   = "us-central1-docker.pkg.dev/launchflow-services-dev/app/app:latest"
  
  # Development environment specifications
  cpu              = "1000m"
  memory           = "512Mi"
  
  # Allow unauthenticated access in dev
  allow_unauthenticated = true
}
