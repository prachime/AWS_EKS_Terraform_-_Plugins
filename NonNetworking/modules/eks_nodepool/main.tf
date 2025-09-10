resource "aws_eks_node_group" "aws_eks_nodes" {
  cluster_name    = var.eks_name
  node_group_name = "${terraform.workspace}-private-ng"
  node_role_arn   = var.eks_alb_node_role_arn
  ami_type        = "BOTTLEROCKET_ARM_64"

  subnet_ids = [
    var.pri_subnet_1,
    var.pri_subnet_2
  ]

  # change the subnest to array

  capacity_type  = "SPOT"
  instance_types = ["c6g.large"]

  scaling_config {
    desired_size = 8
    max_size     = 10
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

  #   depends_on = [
  #     var.worker_node_policy_attach,
  #     var.cni_node_policy_attach,
  #     var.registry_policy_attach,
  #   ]
}