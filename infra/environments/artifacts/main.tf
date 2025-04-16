
terraform {
  backend "gcs" {
    bucket = "infra-new-state"
    prefix = "artifacts"
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

resource "google_artifact_registry_repository" "app" {
  location      = "us-central1"
  repository_id = "app"
  description   = "Docker repository for application images"
  format        = "DOCKER"
}
