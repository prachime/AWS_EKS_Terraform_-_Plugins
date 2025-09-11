resource "aws_subnet" "pub_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = element(var.pub_subnet_cidrs, count.index)
  count                   = var.pub_subnet_count
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "${terraform.workspace}-public-${count.index + 1}-subnet-${var.azs[count.index]}",
    Type = "public"
  }
}

output "public_subnet_ids" {
  value = aws_subnet.pub_subnet[*].id
}