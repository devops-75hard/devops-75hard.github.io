output "sg_ids" {
  description = "Map of SG IDs keyed by SG name. Reference via: module.sgs.sg_ids[\"common\"]"
  value       = { for k, v in aws_security_group.this : k => v.id }
}
