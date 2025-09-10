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