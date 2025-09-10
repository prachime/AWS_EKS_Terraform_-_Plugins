account_id  = "561561535857"
region      = "us-east-1"
environment = "stage"
name        = "sparc"

oidc_id = "44C72D9E05E5A1EBA4F80E22EAB608BD"
vpc_id  = "vpc-0f6e81e61274f7089"

# Variables for S3
s3_bucket_name             = "stage-sparc-s3"
s3_versioning_enabled      = true
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
kms_key_alias = "stage/encrypt-data"
kms_key_usage = "ENCRYPT_DECRYPT"

tags = {
  Environment = "stage"
  Project     = "Sparc"
}


# RDS-related variables
rds_engine                          = "postgres"
rds_engine_version                  = "16.4"
rds_db_cluster_instance_class       = "db.c6gd.medium"
rds_database_name                   = "stage_postgres_db"
rds_username                        = "postgres"
rds_storage_type                    = "gp3"
rds_allocated_storage               = 50
rds_iops                            = 3000
rds_availability_zones              = ["us-east-1a", "us-east-1b", "us-east-1c"]
rds_subnet_ids                      = ["subnet-0e0606b76df5f096d", "subnet-016abd6e88e7a5c16", "subnet-0662dfbdd2a26766f"]
rds_enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
rds_preferred_backup_window         = "04:30-05:30"
rds_preferred_maintenance_window    = "sun:05:30-sun:06:00"
performance_insights_enabled        = "false"
rds_sg_ingress_rules = [
  {
    from_port   = -1
    to_port     = -1
    protocol    = "-1"
    cidr_blocks = ["10.1.0.0/16"]
    description = "Allow acess from dev-sparc-vpc"
  },
  {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["172.17.0.0/16"]
    description = "Allow access from VPN VPC"
  }
]

kms_key_id = "arn:aws:kms:us-east-1:561561535857:key/e70e6161-e7f1-4a64-bbc8-c0638f3ae1cf"
