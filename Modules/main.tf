# This module should create a VPC with the specified CIDR block
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

# Public Subnet module
# This module should create public subnets
module "public_subnet" {
  source                = "./modules/public_subnet"
  vpc_id                = module.vpc.vpc_id
  pub_subnet_count      = var.pub_subnet_count
  pub_subnet_cidrs      = var.pub_subnet_cidrs
  azs                   = var.azs
}

# Private Subnet module
# This module should create private subnets
module "private_subnet" {
  source           = "./modules/private_subnet"
  vpc_id           = module.vpc.vpc_id
  pri_subnet_count = var.pri_subnet_count
  pri_subnet_cidrs = var.pri_subnet_cidrs
  azs              = var.azs
}

# Module for EKS
module "eks" {
  source       = "./modules/eks"
  pri_subnet_1 = var.pri_subnet_1
  pri_subnet_2 = var.pri_subnet_2
  pub_subnet_1 = var.pub_subnet_1
  pub_subnet_2 = var.pub_subnet_2
  account_id   = var.account_id
  oidc_id      = var.oidc_id
  name         = var.name
  security_group_id = module.eks_security_group.security_group_id
}

module "eks_security_group" {
  source        = "./modules/sg"
  name          = "${terraform.workspace}-${var.name}-eks-SG"
  description   = "${terraform.workspace}-${var.name}-eks-SG"
  vpc_id        = var.vpc_id
  ingress_rules = var.eks_sg_ingress_rules
  tags          = merge(var.tags, { Name = "${terraform.workspace}-${var.name}-eks-SG" })
}


module "eks_iam" {
  source                  = "./modules/eks_iam"
  account_id              = var.account_id
  region                  = var.region
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url
  name                    = var.name
  eks_cluster_role_arn    = module.eks.eks_cluster_role_arn
  cluster_name            = module.eks.aws_eks_cluster_name
  oidc_provider_arn       = module.eks.oidc_provider_arn
  oidc_id                 = var.oidc_id
}

module "eks_nodepool" {
  source                = "./modules/eks_nodepool"
  pri_subnet_1          = var.pri_subnet_1
  pri_subnet_2          = var.pri_subnet_2
  eks_alb_node_role_arn = module.eks_iam.eks_alb_node_role_arn
  eks_name              = module.eks.aws_eks_cluster_name
  depends_on            = [module.eks_iam.worker_node_policy_attach, module.eks_iam.cni_node_policy_attach, module.eks_iam.registry_policy_attach]
}

module "ecr" {
  source        = "./modules/ecr"
  service_names = var.ecr_service_names
  tags          = var.tags
  account_id    = var.account_id
}

module "parameter_store" {
  source   = "./modules/parameter_store"
  services = var.parameter_store_services
  tags     = var.tags
  key_id   = var.kms_key_id
}

# module "rds_security_group" {
#   source        = "./modules/sg"
#   name          = "${terraform.workspace}-${var.rds_engine}-db-SG"
#   description   = "${terraform.workspace}-${var.rds_engine}-db-SG"
#   vpc_id        = var.vpc_id
#   ingress_rules = var.rds_sg_ingress_rules
#   tags          = merge(var.tags, { Name = "${terraform.workspace}-${var.rds_engine}-db-SG" })
# }

# module "rds" {
#   source                          = "./modules/rds"
#   identifier                      = "${terraform.workspace}-postgres-db"
#   engine                          = var.rds_engine
#   engine_version                  = var.rds_engine_version
#   db_cluster_instance_class       = var.rds_db_cluster_instance_class
#   availability_zones              = var.rds_availability_zones
#   database_name                   = var.rds_database_name
#   master_username                 = var.rds_username
#   enabled_cloudwatch_logs_exports = var.rds_enabled_cloudwatch_logs_exports
#   subnet_ids                      = var.rds_subnet_ids
#   security_group_id               = module.rds_security_group.security_group_id
#   storage_type                    = var.rds_storage_type
#   allocated_storage               = var.rds_allocated_storage
#   iops                            = var.rds_iops
#   preferred_backup_window         = var.rds_preferred_backup_window
#   preferred_maintenance_window    = var.rds_preferred_maintenance_window
#   tags                            = var.tags
#   performance_insights_enabled    = var.performance_insights_enabled
# }

module "s3" {
  source = "./modules/s3"

  bucket_name             = var.s3_bucket_name
  tags                    = var.tags
  versioning_enabled      = var.s3_versioning_enabled
  block_public_acls       = var.s3_block_public_acls
  block_public_policy     = var.s3_block_public_policy
  ignore_public_acls      = var.s3_ignore_public_acls
  restrict_public_buckets = var.s3_restrict_public_buckets
}

# Module for KMS
module "kms" {
  source    = "./modules/kms"
  key_alias = var.kms_key_alias
  key_usage = var.kms_key_usage
  tags      = var.tags
}