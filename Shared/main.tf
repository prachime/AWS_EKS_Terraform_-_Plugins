# Module for MSK (Managed Streaming for Kafka)
module "msk" {
  source                   = "./modules/msk"
  cluster_name             = "${terraform.workspace}-${var.msk_cluster_name}"
  kafka_version            = var.msk_kafka_version
  number_of_broker_nodes   = var.msk_number_of_broker_nodes
  broker_instance_type     = var.msk_broker_instance_type
  client_subnets           = var.msk_client_subnets
  security_groups          = [module.msk_security_group.security_group_id]
  ebs_volume_size          = var.msk_ebs_volume_size
  client_broker_encryption = var.msk_client_broker_encryption
  in_cluster_encryption    = var.msk_in_cluster_encryption
  kms_key_arn              = var.kms_key_arn
  cloudwatch_logs_enabled  = var.msk_cloudwatch_logs_enabled
  cloudwatch_log_group     = "${terraform.workspace}-${var.msk_cloudwatch_log_group}"
  tags                     = var.tags
}

module "msk_security_group" {
  source        = "./modules/sg"
  name          = "${terraform.workspace}-${var.msk_cluster_name}-db-SG"
  description   = "${terraform.workspace}-${var.msk_cluster_name}-db-SG"
  vpc_id        = var.vpc_id
  ingress_rules = var.msk_sg_ingress_rules
  tags          = merge(var.tags, { Name = "${terraform.workspace}-${var.msk_cluster_name}-SG" })
}