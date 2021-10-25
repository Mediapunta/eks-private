#Route Table 생성

resource "aws_route_table" "junha-pri-eks-private-rt" {
  vpc_id = aws_vpc.junha-pri-eks-vpc.id
}

resource "aws_route_table_association" "junha-eks-pri-2a-asso" {
  subnet_id      = aws_subnet.junha-eks-pri-2a.id
  route_table_id = aws_route_table.junha-pri-eks-private-rt.id
}

resource "aws_route_table_association" "junha-eks-pri-2b-asso" {
  subnet_id      = aws_subnet.junha-eks-pri-2b.id
  route_table_id = aws_route_table.junha-pri-eks-private-rt.id
}

resource "aws_route_table_association" "junha-eks-pri-2c-asso" {
  subnet_id      = aws_subnet.junha-eks-pri-2c.id
  route_table_id = aws_route_table.junha-pri-eks-private-rt.id
}


resource "aws_security_group" "endpoint_ec2" {
  name   = "endpoint-ec2"
  vpc_id = aws_vpc.junha-pri-eks-vpc.id
}

resource "aws_security_group_rule" "endpoint_ec2_443" {
  security_group_id = aws_security_group.endpoint_ec2.id
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

resource "aws_vpc_endpoint" "ec2" {
  vpc_id              = aws_vpc.junha-pri-eks-vpc.id
  service_name        = "com.amazonaws.ap-northeast-2.ec2"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids = [
    aws_subnet.junha-eks-pri-2a.id,
    aws_subnet.junha-eks-pri-2b.id,
    aws_subnet.junha-eks-pri-2c.id,
  ]
  security_group_ids = [
    aws_security_group.endpoint_ec2.id,
  ]
  tags = {
    "Name" = "junha-eks-ec2-endpoint"
    "Env" = "Dev"    
  }
}


resource "aws_security_group" "endpoint_ecr" {
  name   = "endpoint-ecr"
  vpc_id = aws_vpc.junha-pri-eks-vpc.id
}

resource "aws_security_group_rule" "endpoint_ecr_443" {
  security_group_id = aws_security_group.endpoint_ecr.id
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

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.junha-pri-eks-vpc.id
  service_name      = "com.amazonaws.ap-northeast-2.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [
    aws_route_table.junha-pri-eks-private-rt.id,
    # aws_route_table.private-1.id,
    # aws_route_table.private-2.id,
  ]
  tags = {
    "Name" = "junha-eks-s3-endpoint"
    "Env" = "Dev"    
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = aws_vpc.junha-pri-eks-vpc.id
  service_name        = "com.amazonaws.ap-northeast-2.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids = [
    aws_subnet.junha-eks-pri-2a.id,
    aws_subnet.junha-eks-pri-2b.id,
    aws_subnet.junha-eks-pri-2c.id,
  ]

  security_group_ids = [
    aws_security_group.endpoint_ecr.id,
  ]
  tags = {
    "Name" = "junha-eks-ecr-endpoint"
    "Env" = "Dev"    
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = aws_vpc.junha-pri-eks-vpc.id
  service_name        = "com.amazonaws.ap-northeast-2.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids = [
    aws_subnet.junha-eks-pri-2a.id,
    aws_subnet.junha-eks-pri-2b.id,
    aws_subnet.junha-eks-pri-2c.id,
  ]

  security_group_ids = [
    aws_security_group.endpoint_ecr.id,
  ]
  tags = {
    "Name" = "junha-eks-ecr_docker-endpoint"
    "Env" = "Dev"    
  }
}