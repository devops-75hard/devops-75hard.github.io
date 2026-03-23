output "security_group_ids" {
  description = "Map of SG name to SG ID. Use this in other modules e.g. module.security_groups.security_group_ids[\"loadbalancer\"]"
  value       = { for k, v in aws_security_group.this : k => v.id }
}
