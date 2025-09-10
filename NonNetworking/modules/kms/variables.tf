variable "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource"
  type        = number
  default     = 7
}

variable "is_enabled" {
  description = "Specifies whether the key is enabled"
  type        = bool
  default     = true
}

variable "enable_key_rotation" {
  description = "Specifies whether key rotation is enabled"
  type        = bool
  default     = true
}

variable "key_alias" {
  description = "The alias for the KMS key"
  type        = string
}

variable "key_usage" {
  description = "Specifies the intended use of the key (SIGN_VERIFY for asymmetric keys)"
  type        = string
  default     = "SIGN_VERIFY"
}

variable "tags" {
  description = "A map of tags to add to the KMS key"
  type        = map(string)
  default     = {}
}