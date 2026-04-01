module "vpcs" {
  source   = "../../../../services/vpc"
  for_each = var.vpcs

  env             = local.env
  prefix          = local.prefix
  name            = each.value.name
  cidr_block      = each.value.cidr_block
  public_subnets  = each.value.public_subnets
  private_subnets = each.value.private_subnets
  tags            = each.value.tags
}
