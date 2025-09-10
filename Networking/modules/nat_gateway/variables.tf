variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet where the NAT Gateway will be created"
  type        = string
}

variable "eip_count" {
  description = "Number of Elastic IPs to create for NAT Gateway"
  type        = number
  default     = 1
}