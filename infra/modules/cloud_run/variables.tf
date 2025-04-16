
variable "service_name" {
  description = "Name of the Cloud Run service"
  type        = string
}

variable "location" {
  description = "Location where the Cloud Run service will be deployed"
  type        = string
}

variable "service_account_id" {
  description = "ID for the service account"
  type        = string
}

variable "container_image" {
  description = "Container image to deploy"
  type        = string
}

variable "cpu" {
  description = "CPU limits for the service"
  type        = string
  default     = "1000m"
}

variable "memory" {
  description = "Memory limits for the service"
  type        = string
  default     = "512Mi"
}

variable "allow_unauthenticated" {
  description = "Allow unauthenticated access to the service"
  type        = bool
  default     = true
}
