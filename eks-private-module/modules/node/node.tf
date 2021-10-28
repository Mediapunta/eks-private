resource "aws_eks_node_group" "eks_worker_node" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_name
  node_role_arn   = var.node_role_arn 
  version         = var.node_version
  instance_types  = var.instance_type
  ami_type        = var.ami_type
  disk_size       = var.disk_size
  subnet_ids      = var.subnet_ids

  # subnet_ids = [
  #   aws_subnet.junha-eks-pri-2a.id,
  #   aws_subnet.junha-eks-pri-2b.id,
  #   aws_subnet.junha-eks-pri-2c.id,
  # ]

  remote_access {
    ec2_ssh_key   = var.ec2_ssh_key 
  }

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }
}