resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  count             = length(var.ingress_rules)
  security_group_id = aws_security_group.this.id

  from_port   = var.ingress_rules[count.index].from_port
  to_port     = var.ingress_rules[count.index].to_port
  ip_protocol = var.ingress_rules[count.index].protocol
  cidr_ipv4   = var.ingress_rules[count.index].cidr_blocks[0]
}

resource "aws_vpc_security_group_egress_rule" "this" {
  security_group_id = aws_security_group.this.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.this.id
}

output "security_group_arn" {
  description = "The ARN of the security group"
  value       = aws_security_group.this.arn
}