output "cluster_endpoint" {
  description = "The cluster endpoint"
  value       = aws_rds_cluster.this.endpoint
}

output "cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = aws_rds_cluster.this.reader_endpoint
}

output "cluster_identifier" {
  description = "The RDS Cluster Identifier"
  value       = aws_rds_cluster.this.cluster_identifier
}

output "database_name" {
  description = "The database name"
  value       = aws_rds_cluster.this.database_name
}