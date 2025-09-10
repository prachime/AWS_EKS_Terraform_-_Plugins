resource "aws_ssm_parameter" "parameters" {
  count = length(var.services)

  name  = "/${terraform.workspace}/${var.services[count.index]}"
  type  = "SecureString"
  value = " "
  key_id = var.key_id

  tags = var.tags
}

