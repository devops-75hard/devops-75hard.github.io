output "tg_arn" {
  description = "ARN of the target group. Used by ALB listeners."
  value       = aws_lb_target_group.this.arn
}

output "tg_name" {
  description = "Name of the target group"
  value       = aws_lb_target_group.this.name
}
