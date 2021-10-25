resource "aws_subnet" "junha-eks-pri-2a" {
  availability_zone = "ap-northeast-2a"
  cidr_block        = "10.20.1.0/24"
  vpc_id            = aws_vpc.junha-pri-eks-vpc.id

  tags = {
    "kubernetes.io/cluster/junha-pri-eks" = "shared"
    "Name" = "junha-eks-pri-2a"
    "Env" = "Dev"    
  }
}

resource "aws_subnet" "junha-eks-pri-2b" {
  availability_zone = "ap-northeast-2b"
  cidr_block        = "10.20.2.0/24"
  vpc_id            = aws_vpc.junha-pri-eks-vpc.id

  tags = {
    "kubernetes.io/cluster/junha-pri-eks" = "shared"
    "Name" = "junha-eks-pri-2b"
    "Env" = "Dev"    
  }
}

resource "aws_subnet" "junha-eks-pri-2c" {
  availability_zone = "ap-northeast-2c"
  cidr_block        = "10.20.3.0/24"
  vpc_id            = aws_vpc.junha-pri-eks-vpc.id

  tags = {
    "kubernetes.io/cluster/junha-pri-eks" = "shared"
    "Name" = "junha-eks-pri-2c"
    "Env" = "Dev"    
  }
}