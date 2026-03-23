output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "Map of public subnet name to subnet ID"
  value       = { for k, v in aws_subnet.public : k => v.id }
}

output "private_subnet_ids" {
  description = "Map of private subnet name to subnet ID"
  value       = { for k, v in aws_subnet.private : k => v.id }
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.this.id
}

output "public_subnet_cidrs" {
  description = "Map of public subnet name to CIDR block"
  value       = { for k, v in aws_subnet.public : k => v.cidr_block }
}

output "private_subnet_cidrs" {
  description = "Map of private subnet name to CIDR block"
  value       = { for k, v in aws_subnet.private : k => v.cidr_block }
}
