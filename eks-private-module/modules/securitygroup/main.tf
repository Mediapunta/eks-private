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

# locals {
#     csv_filename = "../../dev/security_group/sg_csv/${var.project}-${var.service}-sg.csv"
#     csv = file("${local.csv_filename}")
#     sg_rules = csvdecode(local.csv)
# }

# module "sg_rule" {
#     source          = "./rule"
#     for_each        = { for rule in local.sg_rules : rule.key=> rule }
#     sg_id           = aws_security_group.sg_group.id
#     rule_type       = each.value.rule_type
#     from_port       = each.value.from_port
#     to_port         = each.value.to_port
#     protocol        = each.value.protocol
#     src_or_dst_type = each.value.src_or_dst_type
#     destination     = each.value.src_or_dst
#     description     = each.value.desc
# }