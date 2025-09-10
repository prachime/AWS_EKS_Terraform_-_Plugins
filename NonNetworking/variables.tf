variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "oidc_id" {
  description = "OIDC ID for EKS Cluster"
  type        = string
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

variable "kms_key_alias" {
  description = "The alias for the KMS key"
  type        = string
}

variable "kms_key_usage" {
  description = "Specifies the intended use of the key"
  type        = string
  default     = "SIGN_VERIFY"
}


variable "pub_subnet_1" {
  type        = string
  description = "Public subnet 1"
}

variable "pub_subnet_2" {
  type        = string
  description = "Public subnet 2"
}

variable "pri_subnet_1" {
  type        = string
  description = "Private subnet 1"
}

variable "pri_subnet_2" {
  type        = string
  description = "Private subnet 2"
}

variable "name" {
  description = "Name of the project"
  type        = string
}

# Parameter store
variable "parameter_store_services" {
  description = "List of service names for which to create parameters"
  type        = list(string)
}

# ECR 
variable "ecr_service_names" {
  description = "List of service names for which ECR repositories should be created"
  type        = list(string)
}

# Variables for S3

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "s3_versioning_enabled" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = false
}

variable "s3_block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "s3_block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "s3_ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "s3_restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket"
  type        = bool
  default     = true
}

# RDS variables

variable "rds_username" {
  description = "Username for the RDS master user"
  type        = string
}

variable "rds_engine" {
  description = "Database engine for the RDS instance"
  type        = string
}

variable "rds_engine_version" {
  description = "The engine version for RDS"
  type        = string
}

variable "rds_db_cluster_instance_class" {
  description = "The compute and memory capacity of each DB instance in the Multi-AZ DB cluster"
  type        = string
}

variable "rds_storage_type" {
  description = "One of 'io1', 'gp2', 'gp3', standard (magnetic)"
  type        = string
}

variable "rds_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
}

variable "rds_iops" {
  description = "Storage iops"
  type        = number
}

variable "rds_database_name" {
  description = "Name of the database to create in RDS"
  type        = string
}

variable "rds_sg_ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

variable "rds_availability_zones" {
  description = "List of availability zones for the RDS cluster"
  type        = list(string)
}

variable "rds_subnet_ids" {
  description = "List of subnet IDs for the RDS cluster"
  type        = list(string)
}

variable "rds_enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs"
  type        = list(string)
}

variable "rds_preferred_backup_window" {
  description = "Preferred backup window for RDS"
  type        = string
  default     = "02:00-03:00"
}

variable "rds_preferred_maintenance_window" {
  description = "Preferred maintenance window for RDS"
  type        = string
  default     = "sun:03:00-sun:04:00"
}

variable "performance_insights_enabled" {
  description = "A mapping of tags to assign to the resource"
  type        = bool
}

variable "kms_key_id" {
  description = "Key ID for the parameters"
  type        = string
}