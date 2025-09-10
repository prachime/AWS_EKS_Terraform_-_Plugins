variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "A map of tags to add to the S3 bucket"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "VPC ID for the MQ broker"
  type        = string
}

variable "msk_sg_ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

# MSK Variables
variable "msk_cluster_name" {
  description = "Name of the MSK cluster"
  type        = string
}

variable "msk_kafka_version" {
  description = "Specify the desired Kafka version"
  type        = string
  default     = "2.8.1"
}

variable "msk_number_of_broker_nodes" {
  description = "The desired total number of broker nodes in the kafka cluster"
  type        = number
  default     = 3
}

variable "msk_broker_instance_type" {
  description = "Specify the instance type to use for the kafka brokers"
  type        = string
  default     = "kafka.m5.large"
}

variable "msk_client_subnets" {
  description = "A list of subnets to connect to in client VPC"
  type        = list(string)
}

variable "msk_ebs_volume_size" {
  description = "The size in GiB of the EBS volume for the data drive on each broker node"
  type        = number
  default     = 1000
}

variable "msk_client_broker_encryption" {
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT"
  type        = string
  default     = "TLS"
}

variable "msk_in_cluster_encryption" {
  description = "Whether data communication among broker nodes is encrypted"
  type        = bool
  default     = true
}

variable "msk_cloudwatch_logs_enabled" {
  description = "Indicates whether you want to enable or disable streaming broker logs to Cloudwatch Logs"
  type        = bool
  default     = true
}

variable "msk_cloudwatch_log_group" {
  description = "Name of the Cloudwatch Log Group to deliver logs to"
  type        = string
  default     = null
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for encryption"
  type        = string
  default     = null
}