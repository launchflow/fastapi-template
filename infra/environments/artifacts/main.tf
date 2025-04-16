
terraform {
  backend "gcs" {
    bucket = "infra-new-state"
    prefix = "tanke/v1/artifacts"
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

resource "google_artifact_registry_repository" "app" {
  location      = "us-west1"
  repository_id = "app"
  description   = "Docker repository for application images"
  format        = "DOCKER"
}
