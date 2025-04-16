
variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}

variable "location" {
  description = "Cloud Run service deployment location"
  type        = string
}

variable "service_name" {
  description = "The name of the Cloud Run service to create"
  type        = string
}

variable "image" {
  description = "Container image to deploy"
  type        = string
}

variable "service_account_email" {
  description = "Service account email to run the service as"
  type        = string
}
