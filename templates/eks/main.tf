module "cluster" {
  source = "../../modules/eks/cluster"

  name               = "${var.prefix}-${var.env}-${var.name}"
  kubernetes_version = var.kubernetes_version
  role_arn           = var.role_arn
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids
  tags               = local.common_tags
}

module "node_groups" {
  source   = "../../modules/eks/node_group"
  for_each = var.node_groups

  cluster_name   = module.cluster.name
  name           = "${var.prefix}-${var.env}-${each.key}"
  node_role_arn  = var.node_role_arn
  subnet_ids     = var.subnet_ids
  instance_types = each.value.instance_types
  ami_type       = each.value.ami_type
  capacity_type  = each.value.capacity_type
  desired_size   = each.value.desired_size
  min_size       = each.value.min_size
  max_size       = each.value.max_size
  tags           = local.common_tags
}

module "pod_identity_agent" {
  source = "../../modules/eks/addon"

  cluster_name = module.cluster.name
  addon_name   = "eks-pod-identity-agent"
  tags         = local.common_tags

  depends_on = [module.node_groups]
}
