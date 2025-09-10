variable "service_names" {
  description = "List of service names for which ECR repositories should be created"
  type        = list(string)
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository"
  type        = string
  default     = "IMMUTABLE"
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}
