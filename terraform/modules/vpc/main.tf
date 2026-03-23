# -----------------------------------------------
# VPC
# -----------------------------------------------
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name   = "${var.prefix}-${var.env}-${var.vpc_name}-vpc"
    env    = var.env
    prefix = var.prefix
  }
}

# -----------------------------------------------
# Internet Gateway
# -----------------------------------------------
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name   = "${var.prefix}-${var.env}-${var.vpc_name}-igw"
    env    = var.env
    prefix = var.prefix
  }
}

# -----------------------------------------------
# Public Subnets
# -----------------------------------------------
resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name   = "${var.prefix}-${var.env}-${var.vpc_name}-${each.key}"
    env    = var.env
    prefix = var.prefix
    tier   = "public"
  }
}

# -----------------------------------------------
# Private Subnets
# -----------------------------------------------
resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name   = "${var.prefix}-${var.env}-${var.vpc_name}-${each.key}"
    env    = var.env
    prefix = var.prefix
    tier   = "private"
  }
}

# -----------------------------------------------
# Elastic IP for NAT Gateway
# -----------------------------------------------
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name   = "${var.prefix}-${var.env}-${var.vpc_name}-nat-eip"
    env    = var.env
    prefix = var.prefix
  }
}

# -----------------------------------------------
# NAT Gateway
# Placed in the first public subnet.
# All private subnets route outbound traffic through this.
# -----------------------------------------------
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public)[0].id

  tags = {
    Name   = "${var.prefix}-${var.env}-${var.vpc_name}-nat"
    env    = var.env
    prefix = var.prefix
  }

  # IGW must exist before NAT Gateway
  depends_on = [aws_internet_gateway.this]
}

# -----------------------------------------------
# Public Route Table
# All public subnets route 0.0.0.0/0 to IGW
# -----------------------------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name   = "${var.prefix}-${var.env}-${var.vpc_name}-public-rt"
    env    = var.env
    prefix = var.prefix
  }
}

resource "aws_route_table_association" "public" {
  for_each = var.public_subnets

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

# -----------------------------------------------
# Private Route Table
# All private subnets route 0.0.0.0/0 to NAT Gateway
# -----------------------------------------------
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name   = "${var.prefix}-${var.env}-${var.vpc_name}-private-rt"
    env    = var.env
    prefix = var.prefix
  }
}

resource "aws_route_table_association" "private" {
  for_each = var.private_subnets

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private.id
}
