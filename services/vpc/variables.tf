variable "env" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
}

variable "prefix" {
  description = "Project name prefix"
  type        = string
}

variable "name" {
  description = "VPC short name (e.g. vpc1)"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {}
}

variable "private_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
    nat_gateway       = optional(string, null)
  }))
  default = {}
}

variable "tags" {
  description = "Additional tags to merge with common tags"
  type        = map(string)
  default     = {}
}
