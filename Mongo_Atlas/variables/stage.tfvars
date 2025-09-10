org_id        = "6737141586fee74941f1cdcc"
region        = "us-east-1"
instance_size = "M10"

teams = {
  "DevOps" = {
    id   = "673724fa64354274a874b076"
    role = "GROUP_OWNER"
  }
}

mongodb_major_version                   = 7.0
mongodb_version_release_system          = "LTS"
cluster_type                            = "REPLICASET"
num_shards                              = 1
num_nodes                               = 3
backup_enabled                          = true
pit_enabled                             = true
disk_size_gb                            = 20
auto_scaling_disk_gb_enabled            = true
auto_scaling_compute_enabled            = true
auto_scaling_compute_scale_down_enabled = true
auto_scaling_compute_min_instance_size  = "M10"
auto_scaling_compute_max_instance_size  = "M30"
volume_type                             = "STANDARD"
disk_iops                               = 1000
encryption_at_rest_enabled              = false
termination_protection_enabled          = true
private_link_enabled                    = true
private_link_vpc_name                   = "stage-sparc-vpc"
private_subnet_ids                      = ["subnet-0e0606b76df5f096d", "subnet-016abd6e88e7a5c16"]
ingress_rules = [
  {
    from_port   = -1
    to_port     = -1
    protocol    = "-1"
    cidr_blocks = ["172.17.0.0/16"]
    description = "VPN VPC CIDR"
  }
]