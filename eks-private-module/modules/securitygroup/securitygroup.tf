resource "aws_security_group" "eks-cluster-sg" {
  name        = var.cluster_sg 
  vpc_id      = var.vpc_id 
  tags = {
    Name = "${var.tag_Name}"
    Env = "${var.tag_Env}"
    Owner = "${var.tag_Owner}"
  }
}

resource "aws_security_group_rule" "inbound_rule" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.eks-cluster-sg.id}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "outbound_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.eks-cluster-sg.id}"

  lifecycle { create_before_destroy = true }
}
