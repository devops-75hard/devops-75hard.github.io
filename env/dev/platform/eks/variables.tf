variable "cluster_name" {
  description = "Short name for the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "node_groups" {
  description = "Map of managed node group configurations"
  type = map(object({
    instance_types = optional(list(string), ["t3.medium"])
    ami_type       = optional(string, "AL2023_x86_64_STANDARD")
    capacity_type  = optional(string, "ON_DEMAND")
    desired_size   = number
    min_size       = number
    max_size       = number
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
