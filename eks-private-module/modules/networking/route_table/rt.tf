#Route Table 생성

resource "aws_route_table" "eks_private_rt" {
    vpc_id = var.vpc_id
    tags = {
        Name = "${var.tag_Name}"
        Env = "${var.tag_Env}"
        Owner = "${var.tag_Owner}"
    }
}

resource "aws_route_table_association" "junha-eks-pri-2a-asso" {
  subnet_id      = var.subnet_id_2a
  route_table_id = aws_route_table.eks_private_rt.id
}

resource "aws_route_table_association" "junha-eks-pri-2b-asso" {
  subnet_id      = var.subnet_id_2b
  route_table_id = aws_route_table.eks_private_rt.id
}

resource "aws_route_table_association" "junha-eks-pri-2c-asso" {
  subnet_id      = var.subnet_id_2c
  route_table_id = aws_route_table.eks_private_rt.id
}