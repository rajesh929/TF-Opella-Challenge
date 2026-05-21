variable "environment" {
  description = "Environment Name"
  type = string

  validation {
    condition = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either dev or prod."
  }
}

variable "location" {
  description = "Location of Resource"
  type = string
  default = "westus3"
}