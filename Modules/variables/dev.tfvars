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

 
oidc_id = "9911F7C5BBBC4D6C0430B6F4E4E47400"
vpc_id  = "vpc-02823e2828bc3f9b0"




# Variables for S3
s3_bucket_name             = "dev_CSSTech"
s3_versioning_enabled      = false
s3_block_public_acls       = true
s3_block_public_policy     = true
s3_ignore_public_acls      = true
s3_restrict_public_buckets = true


pri_subnet_1 = "subnet-02021355534b6fe5d"
pri_subnet_2 = "subnet-08650727de7de4c59"
pub_subnet_1 = "subnet-0d768d9800cc49aad"
pub_subnet_2 = "subnet-0c7b08e3165e802d0"


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


kms_key_id = "arn:aws:kms:us-east-1:097096559031:key/4c0b4b29-8725-4453-b26a-735fbbaae650"

eks_sg_ingress_rules = [
  {
    from_port    = 443
    to_port      = 443
    protocol     = "TCP"
    cidr_blocks  = ["10.1.0.0/16"]
    description  = "Allow access from nonprod-shared-vpc"
  },
  {
    from_port    = 80
    to_port      = 80
    protocol     = "TCP"
    cidr_blocks  = ["10.1.0.0/16"]
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
