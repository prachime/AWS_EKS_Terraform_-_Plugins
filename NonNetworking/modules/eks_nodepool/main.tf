resource "aws_eks_node_group" "aws_eks_nodes" {
  cluster_name    = var.eks_name
  node_group_name = "${terraform.workspace}-private-ng"
  node_role_arn   = var.eks_alb_node_role_arn"

  subnet_ids = [
    var.pri_subnet_1,
    var.pri_subnet_2
  ]


  capacity_type  = var.capacity_type
  instance_types = var.instance_types
  ami_type       = var.ami_type

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  labels = {
    role = "general"
  }

tags = {
 "k8s.io/cluster-autoscaler/enabled"                ="true"
  "k8s.io/cluster-autoscaler/${var.eks_name}"       ="owned"
}