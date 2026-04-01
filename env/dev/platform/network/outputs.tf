output "vpc_ids" {
  description = "The IDs of the VPCs created"
  value       = { for k, v in module.vpcs : k => v.vpc_id }
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = { for k, v in module.vpcs : k => v.public_subnet_ids }
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = { for k, v in module.vpcs : k => v.private_subnet_ids }
}
