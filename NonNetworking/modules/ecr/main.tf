# ECR Module

resource "aws_ecr_repository" "this" {
  count = length(var.service_names)
  name  = "${terraform.workspace}-${var.service_names[count.index]}"

  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = var.tags
}