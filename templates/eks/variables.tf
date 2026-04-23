variable "env" {
  type = string
}

variable "prefix" {
  type = string
}

variable "name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "role_arn_key" {
  description = "Key into all_role_arns for the EKS control plane role"
  type        = string
}

variable "node_role_arn_key" {
  description = "Key into all_role_arns for the EKS node role"
  type        = string
}

variable "vpc_key" {
  description = "Key into all_private_subnet_ids to select the VPC"
  type        = string
}

variable "subnet_keys" {
  description = "List of subnet keys within the selected VPC"
  type        = list(string)
}

variable "all_private_subnet_ids" {
  description = "Full private_subnet_ids map from network remote state"
  type        = map(map(string))
}

variable "all_role_arns" {
  description = "Full role_arns map from IAM remote state"
  type        = map(string)
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "node_groups" {
  type = map(object({
    instance_types = optional(list(string), ["t3.medium"])
    ami_type       = optional(string, "AL2023_x86_64_STANDARD")
    capacity_type  = optional(string, "ON_DEMAND")
    desired_size   = number
    min_size       = number
    max_size       = number
  }))
}

variable "addons" {
  description = "Map of EKS addons keyed by addon name"
  type = map(object({
    version = optional(string, null)
  }))
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
