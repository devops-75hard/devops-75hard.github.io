output "name" {
  value = aws_eks_node_group.this.node_group_name
}

output "status" {
  value = aws_eks_node_group.this.status
}
