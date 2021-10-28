# Terraform을 이용하여 AWS EKS를 프라이빗 서브넷에만 워커노드 배포 하기
AWS EKS - Only Private Subnet Node

Worker Node는 Private Subnet에만 배포하며, VPC에는 Public Subnet는 존재하지 않는다.

AWS가 관리하는 Control Plane과 Worker Node가 연결되기 위해서는 인터넷 연결이 필요하다. 
 - VPC에 Internet Gateway와 Nat Gateway가 필요

외부망 연결을 완전 차단하고 싶은 환경에서 배포하는 방법이다.

전제 조건으로 아래의 서비스가 필요하다.
 - EC2 API 엔드포인트
 - S3 API용 엔드포인트 (G/W Endpoint)
 - ECR API 엔드포인트
 - Docker Registry API 엔드포인트

1. eks-private-module로 이동
2. 모듈 설치 `terraform init`
3. terraform plan / apply 실행하면 EKS 클러스터 및 노드 생성
   * root module(main.tf)에서 변수태그를 수정하여 클러스터 이름 수정


./eks-private-module
├── init.tf
├── main.tf
└── modules
    ├── cluster
    │   ├── cluster.tf
    │   ├── output.tf
    │   └── var.tf
    ├── iam
    │   ├── iam.tf
    │   ├── output.tf
    │   └── var.tf
    ├── networking
    │   ├── endpoint
    │   │   ├── endpoint.tf
    │   │   └── var.tf
    │   ├── route_table
    │   │   ├── output.tf
    │   │   ├── rt.tf
    │   │   └── var.tf
    │   ├── subnet
    │   │   ├── output.tf
    │   │   ├── subnet.tf
    │   │   └── var.tf
    │   └── vpc
    │       ├── output.tf
    │       ├── var.tf
    │       └── vpc.tf
    ├── node
    │   ├── node.tf
    │   ├── output.tf
    │   └── var.tf
    └── securitygroup
        ├── securitygroup.tf
        ├── output.tf
        └── var.tf
