resource "aws_route53_zone" "sparc_route_53_zone" {
  name = "xalts.io"

  dynamic "vpc" {
    for_each = var.sparc_vpc_ids
    content {
      vpc_id     = vpc.value.id
      vpc_region = vpc.value.region
    }
  }
}