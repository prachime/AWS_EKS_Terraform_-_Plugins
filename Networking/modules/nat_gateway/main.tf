# NAT Gateway module

resource "aws_eip" "nat" {
  count = var.eip_count

  tags = {
    Name = "${terraform.workspace}-sparc-nat-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat[0].id
  subnet_id     = var.public_subnet_id

  secondary_allocation_ids = [for eip in slice(aws_eip.nat, 1, length(aws_eip.nat)) : eip.id]

  tags = {
    Name = "${terraform.workspace}-sparc-nat-gw"
  }
}

output "nat_gateway_id" {
  value = aws_nat_gateway.main.id
}