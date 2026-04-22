resource "aws_security_group" "this" {
  for_each = var.security_groups

  name        = "${var.prefix}-${var.env}-${each.key}-sg"
  description = each.value.description
  vpc_id      = var.vpc_id

  tags = { Name = "${var.prefix}-${var.env}-${each.key}-sg" }
}

resource "aws_security_group_rule" "ingress" {
  for_each = local.ingress_rules

  security_group_id        = aws_security_group.this[each.value.sg_key].id
  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  source_security_group_id = lookup(each.value, "source_sg_key", null) != null ? aws_security_group.this[each.value.source_sg_key].id : null
}

resource "aws_security_group_rule" "egress" {
  for_each = local.egress_rules

  security_group_id = aws_security_group.this[each.value.sg_key].id
  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = lookup(each.value, "cidr_blocks", null)
}
