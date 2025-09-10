variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "pub_subnet_count" {
  description = "Number of subnets to create."
  type        = number
}

variable "pri_subnet_count" {
  description = "Number of subnets to create."
  type        = number
}

variable "pri_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets."
  type        = list(string)
}

variable "pub_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets."
  type        = list(string)
}

variable "azs" {
  description = "List of Availability Zones to use."
  type        = list(string)
}

variable "nat_eip_count" {
  description = "Number of Elastic IPs to attach to the NAT Gateway"
  type        = number
  default     = 1
}

# variable "vpn_name" {
#   description = "VPN Name"
#   type        = string
#   default     = null
# }

# variable "vpn_description" {
#   description = "Description of the VPN endpoint"
#   type        = string
#   default     = null
# }

# variable "server_certificate_arn" {
#   description = "ARN of the server certificate"
#   type        = string
#   default     = null
# }

# variable "client_cidr_block" {
#   description = "CIDR block for VPN client IP address assignment"
#   type        = string
#   default     = null
# }

# variable "sg_name" {
#   description = "Name of the security group"
#   type        = string
#   default     = null
# }

# variable "sg_description" {
#   description = "Description of the security group"
#   type        = string
#   default     = null
# }

# variable "sg_ingress_rules" {
#   description = "List of ingress rules for the security group"
#   type = list(object({
#     from_port   = number
#     to_port     = number
#     protocol    = string
#     cidr_blocks = list(string)
#   }))
#   default = []
# }

# variable "sg_tags" {
#   description = "A map of tags to add to the security group"
#   type        = map(string)
#   default     = {}
# }

# variable "auth_type" {
#   description = "Type of authentication for VPN (e.g., 'certificate-authentication' or 'federated-authentication')"
#   type        = string
#   default     = null
# }

# variable "saml_metadata_document_path" {
#   description = "Path to the SAML metadata document file"
#   type        = string
#   default     = null
# }

# variable "connection_log_enabled" {
#   description = "Whether to enable connection logging"
#   type        = bool
#   default     = null
# }

# variable "dns_servers" {
#   description = "List of DNS servers to use for VPN clients"
#   type        = list(string)
#   default     = null
# }

# variable "transport_protocol" {
#   description = "Transport protocol for the VPN connection"
#   type        = string
#   default     = null
# }

# variable "split_tunnel" {
#   description = "Whether to enable split-tunnel mode"
#   type        = bool
#   default     = null
# }

# variable "vpn_port" {
#   description = "Port number for the VPN connection"
#   type        = number
#   default     = null
# }

# variable "authorization_rules" {
#   description = "List of authorization rules for the VPN endpoint"
#   default     = null
#   type = list(object({
#     target_network_cidr = string
#     access_group_id     = string
#   }))
# }

variable "sparc_vpc_ids" {
  description = "A map of VPC IDs and their regions for associating with the private Route53 zone."
  type = map(object({
    id     = string
    region = string
  }))
}

# variable "service_names" {
#   description = "List of service names for which to create parameters"
#   type        = list(string)
# }