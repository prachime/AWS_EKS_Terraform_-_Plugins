variable "org_id" {
  type        = string
  description = "MongoDB Atlas Organization ID"
}

variable "region" {
  type        = string
  description = "AWS region for the cluster"
}

variable "instance_size" {
  type        = string
  description = "Instance size for MongoDB nodes"
}

variable "teams" {
  type        = map(any)
  description = "Teams configuration for the cluster"
}

variable "mongodb_major_version" {
  type        = number
  description = "MongoDB major version"
}

variable "mongodb_version_release_system" {
  type        = string
  description = "MongoDB version release system"
}

variable "cluster_type" {
  type        = string
  description = "Type of MongoDB cluster"
}

variable "num_shards" {
  type        = number
  description = "Number of shards in the cluster"
}

variable "num_nodes" {
  type        = number
  description = "Number of nodes per shard"
}

variable "backup_enabled" {
  type        = bool
  description = "Enable backup for the cluster"
}

variable "pit_enabled" {
  type        = bool
  description = "Enable point in time recovery"
}

variable "disk_size_gb" {
  type        = number
  description = "Disk size in GB"
}

variable "auto_scaling_disk_gb_enabled" {
  type        = bool
  description = "Enable disk autoscaling"
}

variable "auto_scaling_compute_enabled" {
  type        = bool
  description = "Enable compute autoscaling"
}

variable "auto_scaling_compute_scale_down_enabled" {
  type        = bool
  description = "Enable compute scale down"
}

variable "auto_scaling_compute_min_instance_size" {
  type        = string
  description = "Minimum instance size for autoscaling"
}

variable "auto_scaling_compute_max_instance_size" {
  type        = string
  description = "Maximum instance size for autoscaling"
}

variable "volume_type" {
  type        = string
  description = "Volume type for storage"
}

variable "disk_iops" {
  type        = number
  description = "IOPS for the disk"
}

variable "encryption_at_rest_enabled" {
  type        = bool
  description = "Enable encryption at rest"
}

variable "termination_protection_enabled" {
  type        = bool
  description = "Enable termination protection"
}

variable "private_link_enabled" {
  description = "Flag to enable/disable private link"
  type        = bool
  default     = false
}

variable "private_link_vpc_name" {
  description = "Name of the VPC for private link"
  type        = string
  default     = null
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs"
  type        = list(string)
  default     = null
}

variable "ingress_rules" {
  description = "List of ingress rules for the EC2 security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH access"
    }
  ]
}