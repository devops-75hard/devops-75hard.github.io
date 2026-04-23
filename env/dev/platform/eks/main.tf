module "eks" {
  source   = "../../../../templates/eks"
  for_each = var.clusters

  env    = local.env
  prefix = local.prefix

  name               = each.value.name
  kubernetes_version = each.value.kubernetes_version
  role_arn_key       = each.value.role_arn_key
  node_role_arn_key  = each.value.node_role_arn_key
  vpc_key            = each.value.vpc_key
  subnet_keys        = each.value.subnet_keys
  security_group_ids = each.value.security_group_ids
  node_groups        = each.value.node_groups
  addons             = each.value.addons
  tags               = each.value.tags

  all_private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  all_role_arns          = data.terraform_remote_state.iam.outputs.role_arns
}
