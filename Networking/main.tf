# VPC module
# This module should create a VPC with the specified CIDR block
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

# Internet Gateway module
# This module should create an Internet Gateway and attach it to the VPC
module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
}

# NAT Gateway module
# This module should create a NAT Gateway in the first public subnet
module "nat_gateway" {
  source           = "./modules/nat_gateway"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.public_subnet.public_subnet_ids[0]
  eip_count        = var.nat_eip_count
}

# Route Tables module
# This module should create:
# 1. One public route table with a route to the Internet Gateway
# 2. Multiple private route tables (one per private subnet) with a route to the NAT Gateway
module "route_tables" {
  source               = "./modules/route_tables"
  vpc_id               = module.vpc.vpc_id
  internet_gateway_id  = module.internet_gateway.internet_gateway_id
  nat_gateway_id       = module.nat_gateway.nat_gateway_id
  public_subnet_ids    = module.public_subnet.public_subnet_ids
  private_subnet_ids   = module.private_subnet.private_subnet_ids
  private_subnet_count = var.pri_subnet_count
  azs                  = var.azs
}

# Public Subnet module
# This module should create public subnets
module "public_subnet" {
  source                = "./modules/public_subnet"
  vpc_id                = module.vpc.vpc_id
  pub_subnet_count      = var.pub_subnet_count
  pub_subnet_cidrs      = var.pub_subnet_cidrs
  public_route_table_id = module.route_tables.public_route_table_id
  azs                   = var.azs
}

# Private Subnet module
# This module should create private subnets
module "private_subnet" {
  source           = "./modules/private_subnet"
  vpc_id           = module.vpc.vpc_id
  pri_subnet_count = var.pri_subnet_count
  pri_subnet_cidrs = var.pri_subnet_cidrs
  azs              = var.azs
}

# Route Table Associations module
# This module should create:
# 1. Associations between the public route table and all public subnets
# 2. Associations between each private route table and its corresponding private subnet
# 3. Associations between each private route table and the NAT Gateway
# 4. Associations between each private route table and the Internet Gateway

module "route_table_associations" {
  source                  = "./modules/route_table_associations"
  public_subnet_ids       = module.public_subnet.public_subnet_ids
  public_route_table_id   = module.route_tables.public_route_table_id
  private_subnet_ids      = module.private_subnet.private_subnet_ids
  private_route_table_ids = module.route_tables.private_route_table_ids
  depends_on              = [module.public_subnet, module.private_subnet, module.route_tables]
}

# Output the route table IDs for verification
output "public_route_table_id" {
  value       = module.route_tables.public_route_table_id
  description = "ID of the public route table"
}

output "private_route_table_ids" {
  value       = module.route_tables.private_route_table_ids
  description = "IDs of the private route tables"
}

# Verify that the number of private route tables matches the number of private subnets
output "private_route_table_count" {
  value       = length(module.route_tables.private_route_table_ids)
  description = "Number of private route tables created"
}

output "private_subnet_count" {
  value       = var.pri_subnet_count
  description = "Number of private subnets created"
}

# VPN module 
# This module should create a VPN connection with the specified configuration

# module "vpn" {
#   source = "./modules/vpn"

#   vpn_description             = var.vpn_description
#   server_certificate_arn      = var.server_certificate_arn
#   client_cidr_block           = var.client_cidr_block
#   auth_type                   = var.auth_type
#   saml_metadata_document_path = var.saml_metadata_document_path
#   connection_log_enabled      = var.connection_log_enabled
#   dns_servers                 = var.dns_servers
#   transport_protocol          = var.transport_protocol
#   split_tunnel                = var.split_tunnel
#   vpc_id                      = module.vpc.vpc_id
#   vpn_port                    = var.vpn_port
#   security_group_ids          = [module.security_group_vpn.security_group_id]
#   subnet_ids                  = module.private_subnet.private_subnet_ids
#   authorization_rules         = var.authorization_rules
# }

# output "vpn_endpoint_id" {
#   description = "The ID of the Client VPN endpoint"
#   value       = module.vpn.vpn_endpoint_id
# }

# output "vpn_dns_name" {
#   description = "The DNS name to be used by clients when establishing their VPN session"
#   value       = module.vpn.vpn_dns_name
# }


# Security Group module
# This module should create a security group with the specified rule
# module "security_group_vpn" {
#   source = "./modules/sg"

#   name          = var.sg_name
#   description   = var.sg_description
#   vpc_id        = module.vpc.vpc_id
#   ingress_rules = var.sg_ingress_rules
#   tags          = var.sg_tags
# }

# output "security_group_id" {
#   value       = module.security_group_vpn.security_group_id
#   description = "ID of the created security group"
# }

module "route_53_zone" {
  source        = "./modules/route_53"
  sparc_vpc_ids       = var.sparc_vpc_ids
}



