resource "aws_security_group" "endpoint_ec2_sg" {
  name   = "endpoint_ec2_sg"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.tag_Name_endpoint_ec2_sg}"
    Env = "${var.tag_Env}"
    Owner = "${var.tag_Owner}"
  }
}

resource "aws_security_group_rule" "endpoint_ec2_443" {
  security_group_id = aws_security_group.endpoint_ec2_sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = [
    "10.20.1.0/24", // private subnet 1
    "10.20.2.0/24", // private subnet 2
    "10.20.3.0/24", // private subnet 3
  ]
}

resource "aws_vpc_endpoint" "ec2_endpoint" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ec2"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids = var.subnet_ids
  security_group_ids = [
    aws_security_group.endpoint_ec2_sg.id,
  ]
  tags = {
    Name = "${var.tag_Name_ec2_endpoint}"
    Env = "${var.tag_Env}"
    Owner = "${var.tag_Owner}"    
  }
}


resource "aws_security_group" "endpoint_ecr_sg" {
  name   = "endpoint_ecr_sg"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.tag_Name_endpoint_ecr_sg}"
    Env = "${var.tag_Env}"
    Owner = "${var.tag_Owner}"
  }
}

resource "aws_security_group_rule" "endpoint_ecr_443" {
  security_group_id = aws_security_group.endpoint_ecr_sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = [
    "10.20.1.0/24", // private subnet 1
    "10.20.2.0/24", // private subnet 2
    "10.20.3.0/24", // private subnet 3
  ]
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id      = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = var.route_table_ids
  tags = {
    Name = "${var.tag_Name_s3_endpoint}"
    Env = "${var.tag_Env}"
    Owner = "${var.tag_Owner}"  
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id      = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids = var.subnet_ids
  security_group_ids = [
    aws_security_group.endpoint_ecr_sg.id,
  ]
  tags = {
    Name = "${var.tag_Name_ecr_api_endpoint}"
    Env = "${var.tag_Env}"
    Owner = "${var.tag_Owner}" 
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id      = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids = var.subnet_ids
  security_group_ids = [
    aws_security_group.endpoint_ecr_sg.id,
  ]
  tags = {
    Name = "${var.tag_Name_ecr_docker_endpoint}"
    Env = "${var.tag_Env}"
    Owner = "${var.tag_Owner}"    
  }
}