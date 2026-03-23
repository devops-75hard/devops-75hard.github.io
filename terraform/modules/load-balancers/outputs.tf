output "lb_arns" {
  description = "Map of lb_key to ALB ARN"
  value       = { for k, v in aws_lb.this : k => v.arn }
}

output "lb_dns_names" {
  description = "Map of lb_key to ALB DNS name. Use this for Route53 or CNAME records."
  value       = { for k, v in aws_lb.this : k => v.dns_name }
}

output "listener_arns" {
  description = "Map of listener_key to listener ARN"
  value       = { for k, v in aws_lb_listener.this : k => v.arn }
}
