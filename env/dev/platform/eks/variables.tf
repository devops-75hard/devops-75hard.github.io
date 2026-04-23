variable "clusters" {
  description = "Map of EKS cluster configurations"
  type = map(object({
    name               = string
    kubernetes_version = string
    role_arn_key       = string
    node_role_arn_key  = string
    vpc_key            = string
    subnet_keys        = list(string)
    security_group_ids = optional(list(string), [])
    node_groups = map(object({
      instance_types = optional(list(string), ["t3.medium"])
      ami_type       = optional(string, "AL2023_x86_64_STANDARD")
      capacity_type  = optional(string, "ON_DEMAND")
      desired_size   = number
      min_size       = number
      max_size       = number
    }))
    addons = optional(map(object({
      version = optional(string, null)
    })), {})
    tags = optional(map(string), {})
  }))
}
