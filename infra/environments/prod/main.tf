
provider "google" {
  project = "launchflow-services-dev"  # You may want to use a different project for production
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
  repository_id = "fastapi-app-prod"
  description   = "Docker repository for FastAPI application production images"

  depends_on = [google_project_service.services]
}

module "cloud_run" {
  source = "../../modules/cloud-run"

  service_name        = "fastapi-app-prod"
  location            = "us-west1"
  container_image     = "${module.artifact_registry.repository_url}/fastapi-app:stable"
  container_port      = 80
  cpu                 = "2"
  memory              = "1Gi"
  min_instances       = 1  # Always keep at least one instance running
  max_instances       = 5  # Allow scaling to more instances for production traffic
  allow_public_access = true

  depends_on = [google_project_service.services]
}

terraform {
  backend "gcs" {
    bucket = "infra-new-state"
    prefix = "terraform/state/fastapi-app/prod"
  }
}
