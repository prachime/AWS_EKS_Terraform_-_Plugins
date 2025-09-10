output "arn" {
  description = "Amazon Resource Name (ARN) of the MSK cluster"
  value       = aws_msk_cluster.kafka_cluster.arn
}

output "bootstrap_brokers" {
  description = "Comma separated list of one or more hostname:port pairs of kafka brokers suitable to bootstrap connectivity to the kafka cluster"
  value       = aws_msk_cluster.kafka_cluster.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = aws_msk_cluster.kafka_cluster.bootstrap_brokers_tls
}

output "bootstrap_brokers_sasl_scram" {
  description = "SASL SCRAM connection host:port pairs"
  value       = aws_msk_cluster.kafka_cluster.bootstrap_brokers_sasl_scram
}

output "bootstrap_brokers_sasl_iam" {
  description = "IAM connection host:port pairs"
  value       = aws_msk_cluster.kafka_cluster.bootstrap_brokers_sasl_iam
}

output "zookeeper_connect_string" {
  description = "A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster"
  value       = aws_msk_cluster.kafka_cluster.zookeeper_connect_string
}

output "zookeeper_connect_string_tls" {
  description = "A comma separated list of one or more hostname:port pairs to use to connect securely to the Apache Zookeeper cluster"
  value       = aws_msk_cluster.kafka_cluster.zookeeper_connect_string_tls
}

output "log_group_name" {
  description = "Name of the CloudWatch log group created for MSK broker logs"
  value       = var.create_cloudwatch_log_group ? aws_cloudwatch_log_group.msk_log_group[0].name : var.cloudwatch_log_group
}