module "roles" {
  source   = "../../../../templates/iam"
  for_each = var.roles

  env                     = local.env
  prefix                  = local.prefix
  name                    = each.value.name
  assume_role_policy      = each.value.assume_role_policy
  create_instance_profile = each.value.create_instance_profile
  policies                = each.value.policies
  inline_policies         = each.value.inline_policies
  managed_policy_arns     = each.value.managed_policy_arns
  tags                    = each.value.tags
}
