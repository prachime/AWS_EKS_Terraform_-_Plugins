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

data "aws_iam_policy_document" "repository_policy" {
  statement {
    sid    = "AllowPushPull"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::588738570692:root",
        "arn:aws:iam::443370703496:role/EC2-Pipeline-Agent-For-AzureDevOps",
      ]
    }

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
  }
}



resource "aws_ecr_repository_policy" "repository_policy" {
  count      = length(var.service_names)
  repository = aws_ecr_repository.this[count.index].name
  policy     = data.aws_iam_policy_document.repository_policy.json
}