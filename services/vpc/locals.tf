locals {
  common_tags = merge({
    Environment = var.env
    Project     = var.prefix
    Service     = "vpc-network"
  }, var.tags)

  nat_gateways = toset([
    for v in values(var.private_subnets) : v.nat_gateway
    if v.nat_gateway != null
  ])

  private_associations = {
    for k, v in var.private_subnets : k => v.nat_gateway
    if v.nat_gateway != null
  }

  isolated_subnets = {
    for k, v in var.private_subnets : k => k
    if v.nat_gateway == null
  }
}
