# kubernetes 클러스터가 리소스 관리하기 위한 권한 생성
variable "project" {
    default = "JunHa-EKS"
}

module "eks-vpc" {
    source = "./modules/networking/vpc"
    cidr_block = "10.20.0.0/16"  
    enable_dns_hostname = true    ## 노드가 클러스터에 조인하기 위해서 필수 / Endpoint access에 사용되므로 필수
    enable_dns_support = true    ## 노드가 클러스터에 조인하기 위해서 필수 / Endpoint access에 사용되므로 필수
    tag_Name = "${var.project}-Pri-VPC"
    tag_Env = "Dev"
    tag_Owner = "junha"  
}

module "eks-vpc-subnet" {
    source = "./modules/networking/subnet"
    vpc_id = module.eks-vpc.vpc_id
    az_2a = "ap-northeast-2a"
    cidr_block_sub_2a = "10.20.1.0/24" 
    az_2b = "ap-northeast-2b"
    cidr_block_sub_2b = "10.20.2.0/24" 
    az_2c = "ap-northeast-2c"
    cidr_block_sub_2c = "10.20.3.0/24"
    # 2a subnet Tag
    tag_Name_2a = "${var.project}-Pri-2a"
    tag_Env = "Dev"
    tag_Owner = "junha"  
    # 2b subnet Tag
    tag_Name_2b = "${var.project}-Pri-2b"
    # 2c subnet Tag
    tag_Name_2c = "${var.project}-Pri-2c"
}

module "eks_vpc_route_table" {
    source = "./modules/networking/route_table"
    vpc_id = module.eks-vpc.vpc_id
    subnet_id_2a = module.eks-vpc-subnet.subnet_id-2a
    subnet_id_2b = module.eks-vpc-subnet.subnet_id-2b
    subnet_id_2c = module.eks-vpc-subnet.subnet_id-2c
    tag_Name = "${var.project}-Pri-RT"
    tag_Env = "Dev"
    tag_Owner = "junha"   
}

module "endpoint" {
    source = "./modules/networking/endpoint"
    region = "ap-northeast-2"
    vpc_id = module.eks-vpc.vpc_id
    subnet_ids          = [module.eks-vpc-subnet.subnet_id-2a, module.eks-vpc-subnet.subnet_id-2b, module.eks-vpc-subnet.subnet_id-2c] 
    route_table_ids     = [module.eks_vpc_route_table.route_table_id] 
    tag_Env = "Dev"
    tag_Owner = "junha"  
    #EC2 API Endpoint Tag
    tag_Name_ec2_endpoint = "${var.project}-ec2-endpoint"
    tag_Name_endpoint_ec2_sg = "${var.project}-endpoint_ec2_sg"
    #S3 API Endpoint Tag
    tag_Name_s3_endpoint = "${var.project}-s3-endpoint"
    #ECR/Docker Reg API Endpoint Tag
    tag_Name_endpoint_ecr_sg = "${var.project}-endpoint_ecr_sg"
    tag_Name_ecr_api_endpoint = "${var.project}-ecr-endpoint"
    tag_Name_ecr_docker_endpoint = "${var.project}-ecr_docker-endpoint}"
}

module "eks-cluster-sg" {
    source = "./modules/securitygroup"
    cluster_sg = "${var.project}-cluster-sg"  
    vpc_id = module.eks-vpc.vpc_id
    tag_Name = "${var.project}-cluster-sg"
    tag_Env = "Dev"
    tag_Owner = "junha" 
}


module "iam-role-eks-cluster" {
    source = "./modules/iam"
    cluster_role_name = "${var.project}-AmazonEKSClusterRole"
    node_role_name = "${var.project}-AmazonEKSNodeRole"
}

#EKS Cluster 생성
module "eks-cluster-create" {
    source = "./modules/cluster"
    cluster_role_arn    =  module.iam-role-eks-cluster.cluster-role-arn
    cluster_name        = "${var.project}-EKS"
    cluster_version     = "1.21"
    subnet_ids          = [module.eks-vpc-subnet.subnet_id-2a, module.eks-vpc-subnet.subnet_id-2b, module.eks-vpc-subnet.subnet_id-2c]
    cluster_sg          = [module.eks-cluster-sg.eks_cluster_sg_id]
    endpoint_private    = true # default = false
    endpoint_public     = true # default = true
    tag_Name = "${var.project}-EKS"
    tag_Env = "Dev"
    tag_Owner = "junha"  
}

# # EKS Cluster Node Group 생성
module "eks-node-create" {
    source = "./modules/node"
    node_role_arn       = module.iam-role-eks-cluster.node-role-arn
    cluster_name        = module.eks-cluster-create.cluster_name
    node_name           = "${var.project}-EKS-Worker" 
    node_version        = "1.21"
    subnet_ids          = [module.eks-vpc-subnet.subnet_id-2a, module.eks-vpc-subnet.subnet_id-2b, module.eks-vpc-subnet.subnet_id-2c]
    ec2_ssh_key         = "junha-seoul"
    instance_type       = ["t3.small"] #["t3.small"]
    ami_type            = "AL2_x86_64"
    disk_size           = 20 # default: GB
    desired_size        = 1
    max_size            = 3
    min_size            = 1
} 

output "test1" {
    value = module.eks_vpc_route_table.route_table_id
}

# output "test" {
#     value = module.eks-vpc-subnet.subnet_id-2a
# }