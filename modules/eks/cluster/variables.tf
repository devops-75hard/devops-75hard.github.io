variable "name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "role_arn" {
  description = "ARN of the IAM role for the EKS control plane"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for the cluster VPC config"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Additional security group IDs to attach to the cluster"
  type        = list(string)
  default     = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
