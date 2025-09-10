vpc_id = "vpc-0426d1c49729f092a"

# MSK Variables
msk_cluster_name             = "sparc"
msk_kafka_version            = "3.6.0"
msk_number_of_broker_nodes   = 3
msk_broker_instance_type     = "kafka.t3.small"
msk_client_subnets           = ["subnet-0ea87ab87792ac9bf", "subnet-04a8cd5cc7ab71d70", "subnet-06dc0b612f13b9a35"]
msk_ebs_volume_size          = 10
msk_client_broker_encryption = "TLS"
msk_in_cluster_encryption    = true
msk_cloudwatch_logs_enabled  = true
msk_cloudwatch_log_group     = "msk-cluster"
kms_key_arn                  = "arn:aws:kms:us-east-1:588738570692:key/fc8d3111-e8c1-4fab-9d08-d087f1135332"
msk_sg_ingress_rules = [
  {
    from_port   = -1
    to_port     = -1
    protocol    = "-1"
    cidr_blocks = ["10.3.0.0/16"]
    description = "Allow acess from non-prod-shared-sparc-vpc"
  },
  {
    from_port   = 9098
    to_port     = 9098
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
    description = "Allow access from dev-sparc-vpc"
  },
  {
    from_port   = 9094
    to_port     = 9094
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
    description = "Allow access from dev-sparc-vpc"
  },
  {
    from_port   = 9098
    to_port     = 9098
    protocol    = "tcp"
    cidr_blocks = ["172.17.0.0/16"]
    description = "Allow access from vpn-vpc"
  },
  {
    from_port   = 9094
    to_port     = 9094
    protocol    = "tcp"
    cidr_blocks = ["172.17.0.0/16"]
    description = "Allow access from vpn-vpc"
  }
]

tags = {
  Environment = "non-prod-shared"
  Project     = "Sparc"
}