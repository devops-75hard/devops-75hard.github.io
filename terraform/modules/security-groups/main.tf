resource "aws_security_group" "this" {
  for_each = var.security_groups

  name        = "${var.prefix}-${var.env}-${each.key}-sg"
  description = each.value.description
  vpc_id      = var.vpc_ids[each.value.vpc_key]

  tags = merge(each.value.tags, {
    Name   = "${var.prefix}-${var.env}-${each.key}-sg"
    env    = var.env
    prefix = var.prefix
  })
}

resource "aws_security_group_rule" "ingress" {
  for_each = local.ingress_rules

  type              = "ingress"
  security_group_id = aws_security_group.this[each.value.sg_key].id
  description       = each.value.rule.description
  from_port         = each.value.rule.from_port
  to_port           = each.value.rule.to_port
  protocol          = each.value.rule.protocol

  cidr_blocks              = each.value.rule.source_security_group_key == null ? each.value.rule.cidr_blocks : null
  source_security_group_id = each.value.rule.source_security_group_key != null ? aws_security_group.this[each.value.rule.source_security_group_key].id : null
}

resource "aws_security_group_rule" "egress" {
  for_each = local.egress_rules

  type              = "egress"
  security_group_id = aws_security_group.this[each.value.sg_key].id
  description       = each.value.rule.description
  from_port         = each.value.rule.from_port
  to_port           = each.value.rule.to_port
  protocol          = each.value.rule.protocol
  cidr_blocks       = each.value.rule.cidr_blocks
}
