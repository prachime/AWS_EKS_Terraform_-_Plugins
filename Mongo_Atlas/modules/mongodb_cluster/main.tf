terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas",
      version = "~> 1.21.4"
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE AN ATLAS PROJECT THAT THE CLUSTER WILL RUN INSIDE
# ---------------------------------------------------------------------------------------------------------------------
resource "mongodbatlas_project" "project" {
  name   = "${var.project_name}-sparc"
  org_id = var.org_id

  #Associate teams and privileges if passed, if not - run with an empty object
  dynamic "teams" {
    for_each = var.teams

    content {
      team_id    = teams.value.id
      role_names = [teams.value.role]
    }
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# CREATE MONGODB ATLAS CLUSTER IN THE PROJECT
# ---------------------------------------------------------------------------------------------------------------------

resource "mongodbatlas_advanced_cluster" "cluster" {
  project_id                  = mongodbatlas_project.project.id
  name                        = "${var.cluster_name}-sparc"
  cluster_type                = var.cluster_type
  backup_enabled              = var.backup_enabled
  encryption_at_rest_provider = var.encryption_at_rest_enabled ? "AWS" : "NONE"
  mongo_db_major_version      = var.mongodb_version_release_system == "LTS" ? var.mongodb_major_version : null
  version_release_system      = var.mongodb_version_release_system
  pit_enabled                 = var.pit_enabled
  replication_specs {
    num_shards = var.cluster_type == "REPLICASET" ? null : var.num_shards
    region_configs {
      provider_name = "AWS"
      region_name   = var.region_aws_atlas_map[var.region]
      priority      = 7
      auto_scaling {
        disk_gb_enabled            = var.auto_scaling_disk_gb_enabled
        compute_enabled            = var.auto_scaling_compute_enabled
        compute_min_instance_size  = var.auto_scaling_compute_enabled ? var.auto_scaling_compute_min_instance_size : null
        compute_max_instance_size  = var.auto_scaling_compute_enabled ? var.auto_scaling_compute_max_instance_size : null
        compute_scale_down_enabled = var.auto_scaling_compute_scale_down_enabled
      }
      electable_specs {
        instance_size   = var.instance_size
        disk_iops       = var.disk_iops
        ebs_volume_type = var.volume_type
        node_count      = var.num_nodes
      }
    }
  }
  termination_protection_enabled = var.termination_protection_enabled
}


data "aws_vpc" "selected" {
  count = var.private_link_enabled ? 1 : 0
  tags = {
    Name = "${var.private_link_vpc_name}"
  }
}

resource "aws_security_group" "mongodb_private" {
  count       = var.private_link_enabled ? 1 : 0
  name        = "mongodb-${var.private_link_vpc_name}-sparc-private-link"
  description = "Security group for MongoDB Atlas private link"
  vpc_id      = data.aws_vpc.selected[0].id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.selected[0].cidr_block]
    description = "Allow all traffic from ${terraform.workspace} VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mongodb-${var.private_link_vpc_name}-sparc-private-link"
  }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  count             = length(var.ingress_rules)
  security_group_id = aws_security_group.mongodb_private[0].id

  from_port   = var.ingress_rules[count.index].from_port
  to_port     = var.ingress_rules[count.index].to_port
  ip_protocol = var.ingress_rules[count.index].protocol
  cidr_ipv4   = var.ingress_rules[count.index].cidr_blocks[0]
  description = var.ingress_rules[count.index].description
}

resource "mongodbatlas_privatelink_endpoint" "privatelink" {
  count         = var.private_link_enabled ? 1 : 0
  project_id    = mongodbatlas_project.project.id
  provider_name = "AWS"
  region        = var.aws_private_link_region
}

resource "mongodbatlas_privatelink_endpoint_service" "privatelink_service" {
  count               = var.private_link_enabled ? 1 : 0
  project_id          = mongodbatlas_project.project.id
  private_link_id     = mongodbatlas_privatelink_endpoint.privatelink[0].private_link_id
  endpoint_service_id = aws_vpc_endpoint.mongodb_private[0].id
  provider_name       = "AWS"
}

resource "aws_vpc_endpoint" "mongodb_private" {
  count             = var.private_link_enabled ? 1 : 0
  vpc_id            = data.aws_vpc.selected[0].id
  service_name      = mongodbatlas_privatelink_endpoint.privatelink[0].endpoint_service_name
  vpc_endpoint_type = "Interface"

  subnet_ids = var.private_subnet_ids

  security_group_ids = [
    aws_security_group.mongodb_private[0].id,
  ]

  tags = {
    Name = "mongodb-${var.private_link_vpc_name}-sparc-private-link"
  }
}