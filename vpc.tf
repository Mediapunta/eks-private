resource "aws_vpc" "junha-pri-eks-vpc" {
    cidr_block           = "10.20.0.0/16"
    enable_dns_support   = true    ## Endpoint access에 사용되므로 필수
    enable_dns_hostnames = true  
    tags = {
        "kubernetes.io/cluster/junha-pri-eks" = "shared"
        "Name" = "junha-pri-eks-vpc"
        "Env" = "Dev"
    }
}
