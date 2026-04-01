module "vpc" {
  source     = "../../modules/vpc"
  name       = "${var.prefix}-${var.env}-${var.name}"
  cidr_block = var.cidr_block
  tags       = local.common_tags
}

module "igw" {
  source = "../../modules/igw"
  vpc_id = module.vpc.vpc_id
  name   = "${var.prefix}-${var.env}-${var.name}-igw"
  tags   = local.common_tags
}

module "public_subnets" {
  source   = "../../modules/subnet"
  for_each = var.public_subnets

  vpc_id            = module.vpc.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  name              = "${var.prefix}-${var.env}-${var.name}-${each.key}"
  tags              = local.common_tags
}

module "private_subnets" {
  source   = "../../modules/subnet"
  for_each = var.private_subnets

  vpc_id            = module.vpc.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  name              = "${var.prefix}-${var.env}-${var.name}-${each.key}"
  tags              = local.common_tags
}

module "nat_gateways" {
  source   = "../../modules/nat"
  for_each = local.nat_gateways

  public_subnet_id = module.public_subnets[each.key].id
  igw_id           = module.igw.id
  name             = "${var.prefix}-${var.env}-${var.name}-nat-${each.key}"
  tags             = local.common_tags
}

module "public_rt" {
  source = "../../modules/rt"
  vpc_id = module.vpc.vpc_id
  name   = "${var.prefix}-${var.env}-${var.name}-public-rt"
  tags   = local.common_tags
}

module "private_rt" {
  source   = "../../modules/rt"
  for_each = local.nat_gateways

  vpc_id = module.vpc.vpc_id
  name   = "${var.prefix}-${var.env}-${var.name}-private-rt-${each.key}"
  tags   = local.common_tags
}

resource "aws_route" "public_igw" {
  route_table_id         = module.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.igw.id
}

resource "aws_route" "private_nat" {
  for_each = local.nat_gateways

  route_table_id         = module.private_rt[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = module.nat_gateways[each.key].id
}

resource "aws_route_table_association" "public" {
  for_each = var.public_subnets

  subnet_id      = module.public_subnets[each.key].id
  route_table_id = module.public_rt.id
}

resource "aws_route_table_association" "private" {
  for_each = local.private_associations

  subnet_id      = module.private_subnets[each.key].id
  route_table_id = module.private_rt[each.value].id
}

module "isolated_rt" {
  source = "../../modules/rt"
  vpc_id = module.vpc.vpc_id
  name   = "${var.prefix}-${var.env}-${var.name}-isolated-rt"
  tags   = local.common_tags
}

resource "aws_route_table_association" "isolated" {
  for_each = local.isolated_subnets

  subnet_id      = module.private_subnets[each.key].id
  route_table_id = module.isolated_rt.id
}
