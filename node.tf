resource "aws_eks_node_group" "junha-pri-eks-worker" {
  cluster_name    = aws_eks_cluster.junha-pri-eks.name
  node_group_name = "junha-pri-eks-worker"
  node_role_arn   = aws_iam_role.iam-role-eks-node.arn  
  instance_types  = ["t3.small"]
  subnet_ids = [
    aws_subnet.junha-eks-pri-2a.id,
    aws_subnet.junha-eks-pri-2b.id,
    aws_subnet.junha-eks-pri-2c.id,
  ]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}