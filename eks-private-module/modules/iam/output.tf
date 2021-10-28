output "cluster-role-name" {
    description = "EKS 클러스터의 권한 부여를 위한 롤 이름"
    value = "${aws_iam_role.iam-role-eks-cluster.name}"
}
output "cluster-role-arn" {
    description = "EKS 클러스터의 권한 부여를 위한 롤 arn"
    value = "${aws_iam_role.iam-role-eks-cluster.arn}"
}
output "node-role-name" {
    description = "EKS 노드의 권한 부여를 위한 롤 이름"
    value = "${aws_iam_role.iam-role-eks-node.name}"
}
output "node-role-arn" {
    description = "EKS 노드의 권한 부여를 위한 롤 arn"
    value = aws_iam_role.iam-role-eks-node.arn
}