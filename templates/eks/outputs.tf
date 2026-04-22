output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.cluster.name
}

output "cluster_endpoint" {
  description = "Private API server endpoint"
  value       = module.cluster.endpoint
}

output "cluster_certificate_authority" {
  description = "Base64-encoded certificate authority data"
  value       = module.cluster.certificate_authority
}

output "node_group_names" {
  description = "Map of node group names keyed by node group key"
  value       = { for k, v in module.node_groups : k => v.name }
}
