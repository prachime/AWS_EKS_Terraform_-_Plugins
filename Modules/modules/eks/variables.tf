variable "pub_subnet_1" {
  type        = string
  description = "Public subnet 1"
}

variable "pub_subnet_2" {
  type        = string
  description = "Public subnet 2"
}

variable "pri_subnet_1" {
  type        = string
  description = "Private subnet 1"
}

variable "pri_subnet_2" {
  type        = string
  description = "Private subnet 2"
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}
variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "oidc_id" {
  description = "OIDC ID for EKS Cluster"
  type        = string
}

variable "name" {
  description = "Name of the project"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "security_group_id" {
  description = "The ID of the Security group to associate with the RDS cluster"
  type        = string
}
