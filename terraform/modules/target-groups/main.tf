# -----------------------------------------------
# Target Group
# -----------------------------------------------
resource "aws_lb_target_group" "this" {
  name        = "${var.prefix}-${var.env}-${var.tg_name}-tg"
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    enabled             = var.health_check.enabled
    interval            = var.health_check.interval
    path                = var.health_check.path
    timeout             = var.health_check.timeout
    matcher             = var.health_check.matcher
    protocol            = var.health_check.protocol
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
  }

  tags = {
    Name   = "${var.prefix}-${var.env}-${var.tg_name}-tg"
    env    = var.env
    prefix = var.prefix
  }
}
