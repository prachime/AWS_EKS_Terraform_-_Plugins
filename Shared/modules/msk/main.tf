resource "aws_msk_cluster" "kafka_cluster" {
  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type   = var.broker_instance_type
    client_subnets  = var.client_subnets
    security_groups = var.security_groups

    storage_info {
      ebs_storage_info {
        volume_size = var.ebs_volume_size
      }
    }
  }

  encryption_info {
    encryption_in_transit {
      client_broker = var.client_broker_encryption
      in_cluster    = var.in_cluster_encryption
    }
    encryption_at_rest_kms_key_arn = var.kms_key_arn
  }

  client_authentication {
    unauthenticated = false
    sasl {
      iam = true
    }
    tls { 
    }
  }

  enhanced_monitoring = "PER_TOPIC_PER_PARTITION"

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = var.cloudwatch_logs_enabled
        log_group = var.cloudwatch_log_group
      }
    }
  }

  tags = var.tags
}



resource "aws_cloudwatch_log_group" "msk_log_group" {
  count = var.create_cloudwatch_log_group ? 1 : 0

  name              = var.cloudwatch_log_group
  retention_in_days = var.log_retention_days
  tags              = var.tags
}

