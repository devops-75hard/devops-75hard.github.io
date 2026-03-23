variable "vpc_name" {
  description = "Name of the VPC (used in resource naming)"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC. e.g. 10.0.0.0/16"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnets. Each entry has a cidr_block and availability_zone."
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  description = "Map of private subnets. Each entry has a cidr_block and availability_zone."
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "env" {
  description = "Environment name. e.g. dev, sandbox, prod"
  type        = string
}

variable "prefix" {
  description = "Prefix for all resource names. e.g. 75hardevops"
  type        = string
}
