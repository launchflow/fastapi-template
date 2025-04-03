
provider "google" {
  project = "launchflow-services-dev"
  region  = "us-west1"
}

resource "google_project_service" "services" {
  for_each = toset([
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "iam.googleapis.com"
  ])
  
  project = "launchflow-services-dev"
  service = each.key

  disable_on_destroy = false
}

module "artifact_registry" {
  source = "../../modules/artifact-registry"
  
  location      = "us-west1"
  repository_id = "fastapi-app"
  description   = "Docker repository for FastAPI application images"
  
  depends_on = [google_project_service.services]
}

module "cloud_run" {
  source = "../../modules/cloud-run"
  
  service_name        = "fastapi-app"
  location            = "us-west1"
  container_image     = "${module.artifact_registry.repository_url}/fastapi-app:latest"
  container_port      = 80
  cpu                 = "1"
  memory              = "512Mi"
  min_instances       = 0
  max_instances       = 2
  allow_public_access = true
  
  depends_on = [google_project_service.services]
}

terraform {
  backend "gcs" {
    bucket = "infra-new-state"
    prefix = "terraform/state/fastapi-app/dev"
  }
}
