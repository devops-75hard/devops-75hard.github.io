output "sg_ids" {
  description = "Map of platform SG IDs keyed by SG name. Reference via: data.terraform_remote_state.sg.outputs.sg_ids[\"common\"]"
  value       = { for k, v in aws_security_group.this : k => v.id }
}
