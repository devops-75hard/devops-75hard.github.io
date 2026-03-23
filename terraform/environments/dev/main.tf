module "vpc" {
  source = "../../modules/vpc"

  for_each = var.vpcs

  vpc_name        = each.key
  cidr_block      = each.value.cidr_block
  public_subnets  = each.value.public_subnets
  private_subnets = each.value.private_subnets
  env             = local.env
  prefix          = local.prefix
}

module "security_groups" {
  source = "../../modules/security-groups"

  security_groups = var.security_groups
  # resolve vpc_key -> vpc_id from VPC module state
  vpc_ids         = { for k, v in module.vpc : k => v.vpc_id }
  env             = local.env
  prefix          = local.prefix
}

module "target_groups" {
  source   = "../../modules/target-groups"
  for_each = var.target_groups

  tg_name      = each.key
  vpc_id       = module.vpc[each.value.vpc_key].vpc_id
  target_type  = each.value.target_type
  port         = each.value.port
  protocol     = each.value.protocol
  health_check = each.value.health_check
  env          = local.env
  prefix       = local.prefix
}

module "load_balancers" {
  source = "../../modules/load-balancers"

  load_balancers     = var.load_balancers
  security_group_ids = module.security_groups.security_group_ids
  target_group_arns  = { for k, v in module.target_groups : k => v.tg_arn }

  subnet_ids = {
    for k, v in module.vpc : k => merge(v.public_subnet_ids, v.private_subnet_ids)
  }

  env    = local.env
  prefix = local.prefix
}
