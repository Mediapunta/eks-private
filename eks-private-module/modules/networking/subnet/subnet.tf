resource "aws_subnet" "junha-eks-pri-2a" {
  availability_zone = var.az_2a # "ap-northeast-2a"
  cidr_block        = var.cidr_block_sub_2a #"10.20.1.0/24"
  vpc_id            = var.vpc_id  #aws_vpc.junha-pri-eks-vpc.id

  tags = {
    Name = "${var.tag_Name_2a}"
    Env = "${var.tag_Env}"
    Owner = "${var.tag_Owner}"
  }
}

resource "aws_subnet" "junha-eks-pri-2b" {
  availability_zone = var.az_2b # "ap-northeast-2b"
  cidr_block        = var.cidr_block_sub_2b # "10.20.2.0/24"
  vpc_id            = var.vpc_id # aws_vpc.junha-pri-eks-vpc.id

  tags = {
    Name = "${var.tag_Name_2b}"
    Env = "${var.tag_Env}"
    Owner = "${var.tag_Owner}"
  }
}

resource "aws_subnet" "junha-eks-pri-2c" {
  availability_zone = var.az_2c # "ap-northeast-2c"
  cidr_block        = var.cidr_block_sub_2c # "10.20.3.0/24"
  vpc_id            = var.vpc_id # aws_vpc.junha-pri-eks-vpc.id

  tags = {
    Name = "${var.tag_Name_2c}"
    Env = "${var.tag_Env}"
    Owner = "${var.tag_Owner}"
  }
}