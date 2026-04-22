module "eks" {
  source = "../../../../templates/eks"

  env                = local.env
  prefix             = local.prefix
  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  role_arn      = data.terraform_remote_state.iam.outputs.role_arns["eks-cluster"]
  node_role_arn = data.terraform_remote_state.iam.outputs.role_arns["eks-node"]

  # Only NAT-attached private subnets — private-1b is isolated (no NAT) so unsuitable for nodes
  subnet_ids = [
    data.terraform_remote_state.network.outputs.private_subnet_ids["vpc1"]["private-1a"]
  ]

  node_groups = var.node_groups
  tags        = var.tags
}
