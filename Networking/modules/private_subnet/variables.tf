variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "pri_subnet_count" {
  description = "Number of private subnets to create."
  type        = number
}

variable "pri_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets."
  type        = list(string)
}

variable "azs" {
  type        = list(string)
  description = "List of AZs to create subnets in."
}