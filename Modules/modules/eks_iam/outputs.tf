output "eks_alb_node_role_arn" {
  description = "The ARN of EKS ALB Node Role"
  value       = aws_iam_role.aws_iam_eks_alb_node_role.arn
}

# output "eks_cluster_role" {
#     value =  aws_iam_eks_asg_role.aws_iam_eks_cluster_role.arn
# }

# output "policy_attach" {
#     value = {}
#     depends_on = [ aws_iam_role_policy_attachment.aws_iam_eks_alb_node_policy_attach ]

# }

# output "worker_node_policy_attach" {
#     value = {}
#     depends_on = [ aws_iam_role_policy_attachment.aws_iam_eks_alb_node_role ]

# }
# output "cni_policy_attach" {
#     value = {}
#     depends_on = [ aws_iam_role_policy_attachment.aws_iam_eks_cni_policy_attach ]

# }
# output "registry_policy_attach" {
#     value = {}
#     depends_on = [ aws_iam_role_policy_attachment.aws_iam_ec2_container_registry_read_only_policy_attach ]

# }