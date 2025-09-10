variable "cluster_name" {
  description = "Name of the MSK cluster"
  type        = string
}

variable "kafka_version" {
  description = "Specify the desired Kafka version"
  type        = string
  default     = "2.8.1"
}

variable "number_of_broker_nodes" {
  description = "The desired total number of broker nodes in the kafka cluster"
  type        = number
  default     = 3
}

variable "broker_instance_type" {
  description = "Specify the instance type to use for the kafka brokers"
  type        = string
  default     = "kafka.m5.large"
}

variable "client_subnets" {
  description = "A list of subnets to connect to in client VPC"
  type        = list(string)
}

variable "security_groups" {
  description = "A list of security group IDs to associate with the MSK cluster"
  type        = list(string)
}

variable "ebs_volume_size" {
  description = "The size in GiB of the EBS volume for the data drive on each broker node"
  type        = number
  default     = 1000
}

variable "client_broker_encryption" {
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT"
  type        = string
  default     = "TLS"
}

variable "in_cluster_encryption" {
  description = "Whether data communication among broker nodes is encrypted"
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used for encrypting data at rest"
  type        = string
  default     = null
}

variable "cloudwatch_logs_enabled" {
  description = "Indicates whether you want to enable or disable streaming broker logs to Cloudwatch Logs"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group" {
  description = "Name of the Cloudwatch Log Group to deliver logs to"
  type        = string
  default     = null
}

variable "create_cloudwatch_log_group" {
  description = "Determines whether to create a CloudWatch log group"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "Number of days to retain log events"
  type        = number
  default     = 7
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}