resource "aws_iam_role" "eks_cluster_role" {
  name = "${terraform.workspace}-${var.name}-eks-cluster-role"
  
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::${var.account_id}:oidc-provider/oidc.eks.${var.region}.amazonaws.com/id/${var.oidc_id}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.${var.region}.amazonaws.com/id/${var.oidc_id}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller",
                    "oidc.eks.${var.region}.amazonaws.com/id/${var.oidc_id}:aud": "sts.amazonaws.com"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com",
                    "ec2.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_policy" "aws_iam_eks_ebs_policy" {
  name = "${terraform.workspace}-${var.name}-eks-ebs-policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeTags",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "ec2:DescribeLaunchTemplateVersions"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_eks_cluster" "aws_eks" {
  name     = "${terraform.workspace}-${var.name}-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  tags = var.tags
  vpc_config {
    subnet_ids = [
      var.pub_subnet_1,
      var.pub_subnet_2,
      var.pri_subnet_1,
      var.pri_subnet_2
    ]
    security_group_ids = [var.security_group_id]
  }
  #depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}

data "tls_certificate" "aws_eks" {
  url = aws_eks_cluster.aws_eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "aws_eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.aws_eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.aws_eks.identity[0].oidc[0].issuer
}

