
variable "project_id" {
  description = "The project ID where resources will be created"
  type        = string
}

variable "location" {
  description = "The location where resources will be created"
  type        = string
}

variable "service_name" {
  description = "The name of the Cloud Run service"
  type        = string
}

variable "container_image" {
  description = "The container image to deploy"
  type        = string
}

variable "cpu" {
  description = "The amount of CPU to allocate to the service"
  type        = string
  default     = "1000m"
}

variable "memory" {
  description = "The amount of memory to allocate to the service"
  type        = string
  default     = "512Mi"
}

variable "public_access" {
  description = "Whether to allow public access to the service"
  type        = bool
  default     = true
}
