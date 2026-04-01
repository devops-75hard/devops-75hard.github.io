output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Map of public subnet IDs keyed by subnet name"
  value       = { for k, v in module.public_subnets : k => v.id }
}

output "private_subnet_ids" {
  description = "Map of private subnet IDs keyed by subnet name"
  value       = { for k, v in module.private_subnets : k => v.id }
}
