variable "load_balancers" {
  description = "Map of load balancers to create."
  type = map(object({
    internal            = optional(bool, true)
    load_balancer_type  = optional(string, "application")
    vpc_key             = string
    subnet_keys         = list(string)
    security_group_keys = list(string)
    tags                = map(string)
    listeners = map(object({
      port     = optional(number, 80)
      protocol = optional(string, "HTTP")
      default_action = object({
        type             = optional(string, "forward")
        target_group_key = string
      })
      rules = optional(map(object({
        priority        = number
        host_header     = optional(list(string), [])
        path_pattern    = optional(list(string), [])
        target_groups 	= list(object({
        key    		= string
        weight 		= number
  	}))
      })), {})
    }))
  }))
}

variable "subnet_ids" {
  description = "Nested map of vpc_key -> subnet_key -> subnet_id. Resolved from VPC module outputs."
  type        = map(map(string))
}

variable "security_group_ids" {
  description = "Map of sg_key -> sg_id. Resolved from security groups module outputs."
  type        = map(string)
}

variable "target_group_arns" {
  description = "Map of tg_key -> tg_arn. Resolved from target groups module outputs."
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
