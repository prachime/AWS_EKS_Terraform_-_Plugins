output "repository_urls" {
  description = "The URLs of the ECR repositories"
  value       = aws_ecr_repository.this[*].repository_url
}

output "repository_arns" {
  description = "The ARNs of the ECR repositories"
  value       = aws_ecr_repository.this[*].arn
}