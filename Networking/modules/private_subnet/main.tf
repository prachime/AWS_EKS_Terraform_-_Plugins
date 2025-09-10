resource "aws_subnet" "pri_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = element(var.pri_subnet_cidrs, count.index)
  count             = var.pri_subnet_count
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${terraform.workspace}-sparc-private-${count.index + 1}-subnet-${var.azs[count.index]}",
    Type = "private"
  }
}

output "private_subnet_ids" {
  value = aws_subnet.pri_subnet[*].id
}

