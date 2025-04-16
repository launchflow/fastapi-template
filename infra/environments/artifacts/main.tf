
terraform {
  backend "gcs" {
    bucket = "infra-new-state"
    prefix = "artifacts"
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
