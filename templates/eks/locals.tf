locals {
  common_tags = merge({
    Environment = var.env
    Project     = var.prefix
    Service     = "eks"
  }, var.tags)
}
