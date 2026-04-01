resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = merge({ Name = var.name }, var.tags)
}
