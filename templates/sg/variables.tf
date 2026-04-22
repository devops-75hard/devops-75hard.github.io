variable "vpc_id" {
  description = "ID of the VPC to attach security groups to"
  type        = string
}

variable "prefix" {
  description = "Project name prefix"
  type        = string
}

variable "env" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
}

variable "security_groups" {
  description = "Map of security group definitions including ingress and egress rules"
  type = map(object({
    description = string
    ingress_rules = map(object({
      from_port     = number
      to_port       = number
      protocol      = string
      cidr_blocks   = optional(list(string))
      source_sg_key = optional(string)
    }))
    egress_rules = map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string))
    }))
  }))
}
