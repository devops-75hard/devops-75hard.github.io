variable "vpcs" {
  description = "Map of VPCs to create."
  type = map(object({
    cidr_block = string
    public_subnets = map(object({
      cidr_block        = string
      availability_zone = string
    }))
    private_subnets = map(object({
      cidr_block        = string
      availability_zone = string
    }))
  }))
  default = {}
}

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
  default = {}
}

variable "target_groups" {
  description = "Map of target groups to create."
  type = map(object({
    vpc_key     = string
    target_type = string
    port        = number
    protocol    = string
    health_check = optional(object({
      enabled             = optional(bool, true)
      interval            = optional(number, 30)
      path                = optional(string, "/")
      timeout             = optional(number, 10)
      matcher             = optional(string, "200")
      protocol            = optional(string, "HTTP")
      healthy_threshold   = optional(number, 2)
      unhealthy_threshold = optional(number, 5)
    }), {})
  }))
  default = {}
}

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
        priority         = number
        host_header      = optional(list(string), [])
        path_pattern     = optional(list(string), [])
        target_groups = list(object({
        key    = string
         weight = number
       }))
      })), {})
    }))
  }))
  default = {}
}
