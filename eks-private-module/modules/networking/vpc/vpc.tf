resource "aws_vpc" "junha-pri-eks-vpc" {
    cidr_block           = var.cidr_block
    enable_dns_hostnames = var.enable_dns_hostname         # true    ## 노드가 클러스터에 조인하기 위해서 필수 / Endpoint access에 사용되므로 필수
    enable_dns_support   = var.enable_dns_support          # true    ## 노드가 클러스터에 조인하기 위해서 필수 / Endpoint access에 사용되므로 필수

    tags = {
        Name = "${var.tag_Name}"
        Env = "${var.tag_Env}"
        Owner = "${var.tag_Owner}"
    }
}
