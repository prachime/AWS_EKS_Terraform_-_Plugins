variable "vpn_name" {
  description = "VPN Name"
  type        = string
  default     = "AWS Client VPN"
}

variable "vpn_description" {
  description = "Description of the VPN endpoint"
  type        = string
  default     = "AWS Client VPN"
}

variable "server_certificate_arn" {
  description = "The ARN of the server certificate"
  type        = string
}

variable "client_cidr_block" {
  description = "The IPv4 address range, in CIDR notation, from which to assign client IP addresses"
  type        = string
  default     = "192.168.0.0/22"
}

variable "auth_type" {
  description = "The type of client authentication to be used"
  type        = string
  default     = "federated-authentication"
}

variable "saml_metadata_document_path" {
  description = "The path to the SAML metadata document file"
  type        = string
}

variable "connection_log_enabled" {
  description = "Indicates whether connection logging is enabled"
  type        = bool
  default     = false
}

variable "dns_servers" {
  description = "Information about the DNS servers to be used for DNS resolution"
  type        = list(string)
  default     = ["1.1.1.1", "1.0.0.1"]
}

variable "transport_protocol" {
  description = "The transport protocol to be used by the VPN session"
  type        = string
  default     = "udp"
}

variable "split_tunnel" {
  description = "Indicates whether split-tunnel is enabled on VPN endpoint"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "The ID of the VPC to associate with the VPN endpoint"
  type        = string
}

variable "vpn_port" {
  description = "The port number for the Client VPN endpoint"
  type        = number
  default     = 443
}

variable "security_group_ids" {
  description = "The IDs of one or more security groups to apply to the target network"
  type        = list(string)
}

variable "subnet_ids" {
  description = "The IDs of the subnets to associate with the Client VPN endpoint"
  type        = list(string)
}

variable "authorization_rules" {
  description = "List of authorization rules for the VPN endpoint"
  type = list(object({
    target_network_cidr = string
    access_group_id     = string
  }))
}