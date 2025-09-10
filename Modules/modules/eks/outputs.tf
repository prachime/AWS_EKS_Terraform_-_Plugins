output "cluster_oidc_issuer_url" {
  value = aws_eks_cluster.aws_eks.identity[0].oidc[0].issuer
}

output "aws_eks_cluster_name" {
  value = aws_eks_cluster.aws_eks.name
}

output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.aws_eks.arn
}