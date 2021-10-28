output "cluster_version" {
    description = "cluster의 배포 버전"
    value = aws_eks_cluster.eks_cluster.version
}
output "cluster_name" {
    description = "Cluster 이름"
    value = aws_eks_cluster.eks_cluster.name
}
