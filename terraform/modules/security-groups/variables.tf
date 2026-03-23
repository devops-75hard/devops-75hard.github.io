variable "security_groups" {
  description = "Map of security groups to create."
  type = map(object({
    description = string
    vpc_key     = string
    tags        = map(string)
    ingress_rules = map(object({
      description               = string
      from_port                 = number
      to_port                   = number
      protocol                  = string
      cidr_blocks               = optional(list(string), null)
      source_security_group_key = optional(string, null)
    }))
    egress_rules = map(object({
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string), null)
    }))
  }))
}

variable "vpc_ids" {
  description = "Map of vpc_key to vpc_id. Resolved from VPC module outputs in env."
  type        = map(string)
}

variable "env" {
  description = "Environment name. e.g. dev, sandbox, prod"
  type        = string
}

variable "prefix" {
  description = "Prefix for all resource names. e.g. 75hardevops"
  type        = string
}
