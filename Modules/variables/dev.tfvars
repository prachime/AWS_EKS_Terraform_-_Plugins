account_id  = "097096559031"
region      = "us-east-1"
environment = "dev"
name        = "CSSTech"

role_arn ="arn:aws:iam::097096559031:role/AWSTerraformAdminRole"
session_name="Terraform_dev"

#VPC and SubNet Config
vpc_cidr         = "10.1.0.0/16"
pub_subnet_cidrs = ["10.1.0.0/20", "10.1.16.0/20"]
pri_subnet_cidrs = ["10.1.32.0/20", "10.1.48.0/20","10.1.64.0/20","10.1.80.0/20"]
pub_subnet_count = 2
pri_subnet_count = 4
azs              = ["us-east-1a", "us-east-1b","us-east-1c","us-east-1d"]
nat_eip_count    = 3

 
oidc_id = ""
vpc_id  = ""




# Variables for S3
s3_bucket_name             = "dev_CSSTech"
s3_versioning_enabled      = false
s3_block_public_acls       = true
s3_block_public_policy     = true
s3_ignore_public_acls      = true
s3_restrict_public_buckets = true


pri_subnet_1 = ""
pri_subnet_2 = ""
pub_subnet_1 = ""
pub_subnet_2 = ""


# Parameter stores
parameter_store_services = [
  "frontend",
  "backend",
 
]

# ECR variables
ecr_service_names = [
  "frontend",
  "backend",
]

# KMS variables
kms_key_alias = "dev/encrypt-data"
kms_key_usage = "ENCRYPT_DECRYPT"

tags = {
  Environment = "dev"
  Project     = "CSSTech"
}


# RDS-related variables
# rds_engine                          = "postgres"
# rds_engine_version                  = "16.4"
# rds_db_cluster_instance_class       = "db.c6gd.medium"
# rds_database_name                   = "nonprod_sparc_postgres_db"
# rds_username                        = "postgres"
# rds_storage_type                    = "gp3"
# rds_allocated_storage               = 50
# rds_iops                            = 3000
# rds_availability_zones              = ["us-east-1a", "us-east-1b", "us-east-1c"]
# rds_subnet_ids                      = ["subnet-0e0606b76df5f096d", "subnet-016abd6e88e7a5c16", "subnet-0662dfbdd2a26766f", "subnet-03a2ff09fc99ca899"]
# rds_enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
# rds_preferred_backup_window         = "04:30-05:30"
# rds_preferred_maintenance_window    = "sun:05:30-sun:06:00"
# performance_insights_enabled        = "false"
# rds_sg_ingress_rules = [
#   {
#     from_port   = -1
#     to_port     = -1
#     protocol    = "-1"
#     cidr_blocks = ["172.19.0.0/16"]
#     description = "Allow acess from nonprod-shared-vpc"
#   },
#   {
#     from_port   = 5432
#     to_port     = 5432
#     protocol    = "tcp"
#     cidr_blocks = ["172.17.0.0/16"]
#     description = "Allow access from VPN VPC"
#   },
#   {
#     from_port   = 5432
#     to_port     = 5432
#     protocol    = "tcp"
#     cidr_blocks = ["172.18.0.0/16"]
#     description = "Allow access from dev VPC"
#   }
# ]


kms_key_id = ""

eks_sg_ingress_rules = [
  {
    from_port    = 443
    to_port      = 443
    protocol     = "TCP"
    cidr_blocks  = ["10.202.104.0/23"]
    description  = "Allow access from nonprod-shared-vpc"
  },
  {
    from_port    = 80
    to_port      = 80
    protocol     = "TCP"
    cidr_blocks  = ["10.202.104.0/23"]
    description  = "Allow access from nonprod-shared-vpc"
  }
]

#Nodepool Variables

node_capacity_type    = "SPOT"
node_instance_types   = ["t3.micro"]
node_desired_size     = 1
node_min_size         = 1
node_max_size         = 2
node_ami_type         = "BOTTLEROCKET_ARM_64"
