
variable "project_id" {
  description = "The ID of the project where resources will be created"
  type        = string
}

variable "location" {
  description = "The location where resources will be created"
  type        = string
  default     = "us-central1"
}

variable "service_name" {
  description = "The name of the Cloud Run service"
  type        = string
}

variable "container_image" {
  description = "The container image to deploy"
  type        = string
}

variable "service_account_email" {
  description = "The email of the service account to run the service as"
  type        = string
}

variable "bucket_name" {
  description = "The name of the GCS bucket to access"
  type        = string
}

variable "environment_variables" {
  description = "Additional environment variables to set on the service"
  type        = map(string)
  default     = {}
}

variable "cpu" {
  description = "The amount of CPU to allocate to each instance"
  type        = string
  default     = "1000m"
}

variable "memory" {
  description = "The amount of memory to allocate to each instance"
  type        = string
  default     = "512Mi"
}

variable "min_instances" {
  description = "The minimum number of instances to run"
  type        = number
  default     = 0
}

variable "max_instances" {
  description = "The maximum number of instances to run"
  type        = number
  default     = 100
}

variable "allow_public_access" {
  description = "Whether to allow public access to the service"
  type        = bool
  default     = true
}
