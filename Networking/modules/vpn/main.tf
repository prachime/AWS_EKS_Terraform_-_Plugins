resource "aws_iam_saml_provider" "vpn_saml_provider" {

  name                   = "AWS_SSO_for_Client_VPN"
  saml_metadata_document = file(var.saml_metadata_document_path)
}

resource "aws_ec2_client_vpn_endpoint" "vpn" {

  description            = var.vpn_description
  server_certificate_arn = var.server_certificate_arn
  client_cidr_block      = var.client_cidr_block

  authentication_options {
    type              = var.auth_type
    saml_provider_arn = aws_iam_saml_provider.vpn_saml_provider.arn
  }

  connection_log_options {
    enabled = var.connection_log_enabled
  }

  dns_servers        = var.dns_servers
  transport_protocol = var.transport_protocol
  split_tunnel       = var.split_tunnel
  vpc_id             = var.vpc_id
  vpn_port           = var.vpn_port
  security_group_ids = var.security_group_ids

  tags = {
    Name = var.vpn_name
  }
}

resource "aws_ec2_client_vpn_network_association" "vpn_association" {
  count                  = length(var.subnet_ids)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  subnet_id              = var.subnet_ids[count.index]
}

resource "aws_ec2_client_vpn_authorization_rule" "vpn_authorization" {
  count                  = length(var.authorization_rules)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  target_network_cidr    = var.authorization_rules[count.index].target_network_cidr
  access_group_id        = var.authorization_rules[count.index].access_group_id
}

output "vpn_endpoint_id" {
  description = "The ID of the Client VPN endpoint"
  value       = aws_ec2_client_vpn_endpoint.vpn.id
}

output "vpn_dns_name" {
  description = "The DNS name to be used by clients when establishing their VPN session"
  value       = aws_ec2_client_vpn_endpoint.vpn.dns_name
}
