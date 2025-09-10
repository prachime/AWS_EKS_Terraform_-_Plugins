resource "aws_kms_key" "symmetric_key" {
  key_usage               = var.key_usage
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled              = var.is_enabled
  enable_key_rotation     = false
  tags                    = var.tags
}

resource "aws_kms_alias" "key_alias" {
  name          = "alias/${var.key_alias}"
  target_key_id = aws_kms_key.symmetric_key.key_id
}