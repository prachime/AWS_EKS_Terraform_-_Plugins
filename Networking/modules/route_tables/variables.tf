variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  type        = string
}

variable "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "private_subnet_count" {
  type        = number
  description = "Number of private subnets"
}

variable "azs" {
  type        = list(string)
  description = "List of availability zones"
}


