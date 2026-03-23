variable "tg_name" {
  description = "Name of the target group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the target group will be created"
  type        = string
}

variable "target_type" {
  description = "Type of target. e.g. instance, ip, lambda"
  type        = string
}

variable "port" {
  description = "Port on which targets receive traffic"
  type        = number
}

variable "protocol" {
  description = "Protocol for routing traffic. e.g. HTTP, HTTPS"
  type        = string
}

variable "health_check" {
  description = "Health check configuration. All fields are optional with sensible defaults."
  type = object({
    enabled             = optional(bool, true)
    interval            = optional(number, 30)
    path                = optional(string, "/")
    timeout             = optional(number, 10)
    matcher             = optional(string, "200")
    protocol            = optional(string, "HTTP")
    healthy_threshold   = optional(number, 2)
    unhealthy_threshold = optional(number, 5)
  })
  default = {}
}

variable "env" {
  description = "Environment name. e.g. dev, sandbox, prod"
  type        = string
}

variable "prefix" {
  description = "Prefix for all resource names. e.g. 75hardevops"
  type        = string
}
