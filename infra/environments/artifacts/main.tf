
terraform {
  backend "gcs" {
    bucket = "infra-new-state"
    prefix = "tanke/v2/python-app/artifacts"
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
  description   = "Docker repository for Python application images"
  format        = "DOCKER"
}

resource "google_project_iam_member" "cloudbuild_artifact_registry" {
  project = "launchflow-services-dev"
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
}

data "google_project" "project" {
  project_id = "launchflow-services-dev"
}
