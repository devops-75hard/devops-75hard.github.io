resource "aws_lb" "this" {
  for_each = var.load_balancers

  name               = "${var.prefix}-${var.env}-${each.key}"
  internal           = each.value.internal
  load_balancer_type = each.value.load_balancer_type
  security_groups    = [for sg_key in each.value.security_group_keys : var.security_group_ids[sg_key]]
  subnets            = [for subnet_key in each.value.subnet_keys : var.subnet_ids[each.value.vpc_key][subnet_key]]

  tags = merge(each.value.tags, {
    Name   = "${var.prefix}-${var.env}-${each.key}"
    env    = var.env
    prefix = var.prefix
  })
}

resource "aws_lb_listener" "this" {
  for_each = local.listeners

  load_balancer_arn = aws_lb.this[each.value.lb_key].arn
  port              = each.value.listener.port
  protocol          = each.value.listener.protocol

  default_action {
    type             = each.value.listener.default_action.type
    target_group_arn = var.target_group_arns[each.value.listener.default_action.target_group_key]
  }

  lifecycle {
    ignore_changes = [default_action]
  }
}

resource "aws_lb_listener_rule" "this" {
  for_each = local.rules

  listener_arn = aws_lb_listener.this["${each.value.lb_key}-${each.value.listener_key}"].arn
  priority     = each.value.rule.priority

  action {
    type = "forward"
    forward {
      dynamic "target_group" {
        for_each = each.value.rule.target_groups
        content {
          arn    = var.target_group_arns[target_group.value.key]
          weight = target_group.value.weight
        }
      }
    }
  }

  dynamic "condition" {
    for_each = length(each.value.rule.host_header) > 0 ? [1] : []
    content {
      host_header {
        values = each.value.rule.host_header
      }
    }
  }

  dynamic "condition" {
    for_each = length(each.value.rule.path_pattern) > 0 ? [1] : []
    content {
      path_pattern {
        values = each.value.rule.path_pattern
      }
    }
  }

  lifecycle {
    ignore_changes = [action]
  }
}
