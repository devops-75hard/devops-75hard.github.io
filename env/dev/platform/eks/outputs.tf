output "cluster_names" {
  description = "Map of cluster names keyed by cluster key"
  value       = { for k, v in module.eks : k => v.cluster_name }
}

output "cluster_endpoints" {
  description = "Map of cluster endpoints keyed by cluster key"
  value       = { for k, v in module.eks : k => v.cluster_endpoint }
}

output "node_group_names" {
  description = "Map of node group name maps keyed by cluster key"
  value       = { for k, v in module.eks : k => v.node_group_names }
}
