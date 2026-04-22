module "role" {
  source             = "../../modules/iam/role"
  name               = "${var.prefix}-${var.env}-${var.name}"
  assume_role_policy = var.assume_role_policy
  tags               = local.common_tags
}

module "policies" {
  source   = "../../modules/iam/policy"
  for_each = var.policies

  name        = "${var.prefix}-${var.env}-${var.name}-${each.key}"
  description = each.value.description
  policy      = each.value.policy
  tags        = local.common_tags
}

module "inline_policies" {
  source   = "../../modules/iam/inline_policy"
  for_each = var.inline_policies

  name   = each.key
  role   = module.role.name
  policy = each.value.policy
}

resource "aws_iam_role_policy_attachment" "custom" {
  for_each = module.policies

  role       = module.role.name
  policy_arn = each.value.arn
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset(var.managed_policy_arns)

  role       = module.role.name
  policy_arn = each.value
}

module "instance_profile" {
  source = "../../modules/iam/instance_profile"
  count  = var.create_instance_profile ? 1 : 0

  name = "${var.prefix}-${var.env}-${var.name}"
  role = module.role.name
  tags = local.common_tags
}
