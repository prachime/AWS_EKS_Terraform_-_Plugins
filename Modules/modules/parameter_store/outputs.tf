output "parameter_arns" {
  description = "ARNs of the created SSM parameters"
  value       = aws_ssm_parameter.parameters[*].arn
}