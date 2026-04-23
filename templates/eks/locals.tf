locals {
  common_tags = merge({
    Environment = var.env
    Project     = var.prefix
    Service     = "eks"
  }, var.tags)

  role_arn      = var.all_role_arns[var.role_arn_key]
  node_role_arn = var.all_role_arns[var.node_role_arn_key]
  subnet_ids    = [for k in var.subnet_keys : var.all_private_subnet_ids[var.vpc_key][k]]
}
