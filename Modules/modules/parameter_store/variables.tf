variable "services" {
  description = "List of service names for which to create parameters"
  type        = list(string)
}

variable "tags" {
  description = "Tags to be applied to the parameters"
  type        = map(string)
}

variable "key_id" {
  description = "Key ID for the parameters"
  type        = string
}