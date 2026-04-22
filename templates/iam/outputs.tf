output "role_arn" {
  description = "ARN of the IAM role"
  value       = module.role.arn
}

output "role_name" {
  description = "Name of the IAM role"
  value       = module.role.name
}

output "policy_arns" {
  description = "Map of customer-managed policy ARNs keyed by policy name"
  value       = { for k, v in module.policies : k => v.arn }
}

output "instance_profile_arn" {
  description = "ARN of the instance profile (null if create_instance_profile is false)"
  value       = var.create_instance_profile ? module.instance_profile[0].arn : null
}

output "instance_profile_name" {
  description = "Name of the instance profile (null if create_instance_profile is false)"
  value       = var.create_instance_profile ? module.instance_profile[0].name : null
}
