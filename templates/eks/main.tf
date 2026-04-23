module "cluster" {
  source = "../../modules/eks/cluster"

  name               = "${var.prefix}-${var.env}-${var.name}"
  kubernetes_version = var.kubernetes_version
  role_arn           = local.role_arn
  subnet_ids         = local.subnet_ids
  security_group_ids = var.security_group_ids
  tags               = local.common_tags
}

module "node_groups" {
  source   = "../../modules/eks/node_group"
  for_each = var.node_groups

  cluster_name   = module.cluster.name
  name           = "${var.prefix}-${var.env}-${each.key}"
  node_role_arn  = local.node_role_arn
  subnet_ids     = local.subnet_ids
  instance_types = each.value.instance_types
  ami_type       = each.value.ami_type
  capacity_type  = each.value.capacity_type
  desired_size   = each.value.desired_size
  min_size       = each.value.min_size
  max_size       = each.value.max_size
  tags           = local.common_tags
}

module "addons" {
  source   = "../../modules/eks/addon"
  for_each = var.addons

  cluster_name  = module.cluster.name
  addon_name    = each.key
  addon_version = each.value.version
  tags          = local.common_tags

  depends_on = [module.node_groups]
}
