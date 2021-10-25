resource "aws_eks_cluster" "junha-pri-eks" {
  name     = "junha-pri-eks"
  role_arn = aws_iam_role.iam-role-eks-cluster.arn

  vpc_config {

    subnet_ids = [
      aws_subnet.junha-eks-pri-2a.id,
      aws_subnet.junha-eks-pri-2b.id,
      aws_subnet.junha-eks-pri-2c.id,
    ]

    endpoint_private_access = true
    # endpoint_public_access  = true
    # public_access_cidrs = [
    #   "0.0.0.0/0"
    # ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    # aws_iam_role_policy_attachment.eks_master_default_service_policy,
  ]
}