resource "aws_eks_cluster" "eks_cluster" {
  name      = var.cluster_name
  version   = var.cluster_version
  role_arn  = var.cluster_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = var.cluster_sg

    # subnet_ids = [
    #   aws_subnet.junha-eks-pri-2a.id,
    #   aws_subnet.junha-eks-pri-2b.id,
    #   aws_subnet.junha-eks-pri-2c.id,
    # ]

    endpoint_private_access = var.endpoint_private # default = false
    endpoint_public_access  = var.endpoint_public # default = true
    # public_access_cidrs = [
    #   "0.0.0.0/0"
    # ]
  }
  tags = {
    Name = "${var.tag_Name}"
    Env = "${var.tag_Env}"
    Owner = "${var.tag_Owner}"
  }
}