variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "pub_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "pub_subnet_count" {
  type        = number
  description = "Number of public subnets to create."
}

variable "azs" {
  type        = list(string)
  description = "List of availability zones"
}
