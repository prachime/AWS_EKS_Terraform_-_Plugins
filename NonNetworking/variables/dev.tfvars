account_id  = "443370703496"
region      = "us-east-1"
environment = "dev"
name        = "sparc"

oidc_id = "4A19F590F1B8A7178A35BDB8261D3E13"
vpc_id  = "vpc-0f6e81e61274f7089"


# Variables for S3
s3_bucket_name             = "dev-sparc-s3"
s3_versioning_enabled      = false
s3_block_public_acls       = true
s3_block_public_policy     = true
s3_ignore_public_acls      = true
s3_restrict_public_buckets = true


pub_subnet_1 = "subnet-0bae93935003fd757"
pub_subnet_2 = "subnet-0f29fb647c70f7f71"
pri_subnet_1 = "subnet-0e0606b76df5f096d"
pri_subnet_2 = "subnet-016abd6e88e7a5c16"

# Parameter stores
parameter_store_services = [
  "auth",
  "bank",
  "sprc",
  "ai"
]

# ECR variables
ecr_service_names = [
  "auth",
  "bank",
  "sprc",
  "ai"
]

# KMS variables
kms_key_alias = "dev/encrypt-data"
kms_key_usage = "ENCRYPT_DECRYPT"

tags = {
  Environment = "dev"
  Project     = "Sparc"
}


# RDS-related variables
rds_engine                          = "postgres"
rds_engine_version                  = "16.4"
rds_db_cluster_instance_class       = "db.c6gd.medium"
rds_database_name                   = "nonprod_sparc_postgres_db"
rds_username                        = "postgres"
rds_storage_type                    = "gp3"
rds_allocated_storage               = 50
rds_iops                            = 3000
rds_availability_zones              = ["us-east-1a", "us-east-1b", "us-east-1c"]
rds_subnet_ids                      = ["subnet-0e0606b76df5f096d", "subnet-016abd6e88e7a5c16", "subnet-0662dfbdd2a26766f", "subnet-03a2ff09fc99ca899"]
rds_enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
rds_preferred_backup_window         = "04:30-05:30"
rds_preferred_maintenance_window    = "sun:05:30-sun:06:00"
performance_insights_enabled        = "false"
rds_sg_ingress_rules = [
  {
    from_port   = -1
    to_port     = -1
    protocol    = "-1"
    cidr_blocks = ["172.19.0.0/16"]
    description = "Allow acess from nonprod-shared-vpc"
  },
  {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["172.17.0.0/16"]
    description = "Allow access from VPN VPC"
  },
  {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["172.18.0.0/16"]
    description = "Allow access from dev VPC"
  }
]


kms_key_id = "arn:aws:kms:us-east-1:443370703496:key/5e0ec266-4d7d-4b90-9187-a84ce96d9a41"
