
# FastAPI Application on Google Cloud Run

This repository contains a FastAPI application configured to run on Google Cloud Platform using Cloud Run.

## Infrastructure

The infrastructure is managed using Terraform with the following components:

- **Google Cloud Run**: Hosts the FastAPI application
- **Google Artifact Registry**: Stores the Docker container images

## Development Setup

### Prerequisites

- Google Cloud SDK
- Terraform
- Docker

### Local Development

1. Clone the repository
2. Install dependencies:
   ```
   pip install -r requirements.txt
   ```
3. Run the application locally:
   ```
   uvicorn app.main:app --reload
   ```

### Deployment

#### Manual Deployment

1. Build the Docker image:
   ```
   docker build -t us-west1-docker.pkg.dev/launchflow-services-dev/fastapi-app/fastapi-app:latest .
   ```

2. Push the image to Artifact Registry:
   ```
   docker push us-west1-docker.pkg.dev/launchflow-services-dev/fastapi-app/fastapi-app:latest
   ```

3. Deploy infrastructure with Terraform:
   ```
   # For development
   cd infra/environments/dev
   terraform init
   terraform apply
   
   # For production
   cd infra/environments/prod
   terraform init
   terraform apply
   ```

#### Automated Deployment

The repository includes CI/CD configuration files for Google Cloud Build:

- `cloudbuild.yaml`: For development deployments
- `cloudbuild-prod.yaml`: For production deployments

## Infrastructure Management

The Terraform configuration is organized as follows:

- `infra/modules/`: Reusable Terraform modules
  - `cloud-run/`: Cloud Run service configuration
  - `artifact-registry/`: Artifact Registry configuration
- `infra/environments/`: Environment-specific configurations
  - `dev/`: Development environment
  - `prod/`: Production environment

### Environment Differences

| Feature | Development | Production |
|---------|-------------|------------|
| CPU     | 1 CPU       | 2 CPU      |
| Memory  | 512Mi       | 1Gi        |
| Scaling | 0-2 instances | 1-5 instances |
| Image Tag | latest    | stable     |

## API Endpoints

- `/`: Serves the static HTML page
- `/api/hello`: Returns a random greeting in different languages
