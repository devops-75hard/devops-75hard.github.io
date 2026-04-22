variable "env" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
}

variable "prefix" {
  description = "Project name prefix"
  type        = string
}

variable "name" {
  description = "Cluster short name (e.g. cluster)"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "role_arn" {
  description = "ARN of the IAM role for the EKS control plane"
  type        = string
}

variable "node_role_arn" {
  description = "ARN of the IAM role for EKS worker nodes"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs (NAT-attached) for the cluster and node groups"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Additional security group IDs to attach to the cluster"
  type        = list(string)
  default     = []
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
  description = "Additional tags to merge with common tags"
  type        = map(string)
  default     = {}
}
