variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "engine" {
  description = "The database engine to use"
  type        = string
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
}

variable "availability_zones" {
  description = "A list of EC2 Availability Zones for the DB cluster"
  type        = list(string)
}

variable "database_name" {
  description = "The name of the database to create when the DB instance is created"
  type        = string
}

variable "master_username" {
  description = "Username for the master DB user"
  type        = string
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs"
  type        = list(string)
  default     = []
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = "03:00-04:00"
}

variable "preferred_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the RDS cluster"
  type        = string
}

variable "storage_type" {
  description = "One of 'io1', 'gp2', 'gp3', standard (magnetic)"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
}

variable "iops" {
  description = "Storage iops"
  type        = number
}

variable "db_cluster_instance_class" {
  description = "The compute and memory capacity of each DB instance in the Multi-AZ DB cluster"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "performance_insights_enabled" {
  description = "A mapping of tags to assign to the resource"
  type        = bool
}