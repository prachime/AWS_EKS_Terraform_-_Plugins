resource "aws_db_subnet_group" "this" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = var.tags
}

resource "aws_rds_cluster" "this" {
  cluster_identifier           = var.identifier
  engine                       = var.engine
  engine_version               = var.engine_version
  db_cluster_instance_class    = var.db_cluster_instance_class
  availability_zones           = var.availability_zones
  database_name                = var.database_name
  master_username              = var.master_username
  manage_master_user_password  = true
  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  db_subnet_group_name         = aws_db_subnet_group.this.name
  vpc_security_group_ids       = [var.security_group_id]
  skip_final_snapshot          = true
  storage_encrypted            = true

  storage_type      = var.storage_type
  allocated_storage = var.allocated_storage
  iops              = var.iops

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  performance_insights_enabled    = var.performance_insights_enabled
  deletion_protection             = true

  copy_tags_to_snapshot = true
  tags                  = var.tags
}