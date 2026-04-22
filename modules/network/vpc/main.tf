resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = merge({ Name = var.name }, var.tags)
}
