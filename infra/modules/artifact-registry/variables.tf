
variable "location" {
  description = "GCP region where the repository will be created"
  type        = string
}

variable "repository_id" {
  description = "ID of the repository"
  type        = string
}

variable "description" {
  description = "Description of the repository"
  type        = string
  default     = "Docker repository for application images"
}
