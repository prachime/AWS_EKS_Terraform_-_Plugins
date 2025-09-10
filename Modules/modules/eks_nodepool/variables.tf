variable "pri_subnet_1" {
  type = string
}

variable "pri_subnet_2" {
  type = string
}

variable "eks_alb_node_role_arn" {
  type = string
}

variable "eks_name" {
  type = string

}

variable "worker_node_policy_attach" {
  # the value doesn't matter; we're just using this variable
  # to propagate dependencies.
  type    = any
  default = []
}

variable "cni_node_policy_attach" {
  # the value doesn't matter; we're just using this variable
  # to propagate dependencies.
  type    = any
  default = []
}

variable "registry_policy_attach" {
  # the value doesn't matter; we're just using this variable
  # to propagate dependencies.
  type    = any
  default = []
}


variable "capacity_type" {
  description = "ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"
  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.capacity_type)
    error_message = "capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "instance_types" {
  description = "List of instance types for the node group"
  type        = list(string)
  default     = ["t3g.xlarge"]
}

variable "ami_type" {
  description = "AMI type for EKS managed node groups"
  type        = string
  # Keep your current default
  default     = "BOTTLEROCKET_ARM_64"
}

# NEW: scaling config
variable "desired_size" {
  type    = number
  default = 3
}

variable "min_size" {
  type    = number
  default = 3
}

variable "max_size" {
  type    = number
  default = 5
}

# NEW: rolling update config
variable "max_unavailable" {
  type    = number
  default = 1
}