output "role_arns" {
  description = "Map of IAM role ARNs keyed by role name"
  value       = { for k, v in module.roles : k => v.role_arn }
}

output "role_names" {
  description = "Map of IAM role names keyed by role name"
  value       = { for k, v in module.roles : k => v.role_name }
}

output "policy_arns" {
  description = "Map of customer-managed policy ARN maps, keyed by role then policy name"
  value       = { for k, v in module.roles : k => v.policy_arns }
}

output "instance_profile_arns" {
  description = "Map of instance profile ARNs keyed by role name (null if not created)"
  value       = { for k, v in module.roles : k => v.instance_profile_arn }
}

output "instance_profile_names" {
  description = "Map of instance profile names keyed by role name (null if not created)"
  value       = { for k, v in module.roles : k => v.instance_profile_name }
}
