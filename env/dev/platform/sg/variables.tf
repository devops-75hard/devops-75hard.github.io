variable "vpc_name" {
  description = "Key of the VPC from the network remote state to attach SGs to"
  type        = string
}

variable "security_groups" {
  description = "Map of security group definitions including ingress and egress rules"
  type        = any
}
