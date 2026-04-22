variable "env" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
}

variable "prefix" {
  description = "Project name prefix"
  type        = string
}

variable "name" {
  description = "Role short name (e.g. eks-node)"
  type        = string
}

variable "assume_role_policy" {
  description = "JSON trust policy document for the IAM role"
  type        = string
}

variable "policies" {
  description = "Customer-managed policies to create and attach to this role"
  type = map(object({
    description = optional(string, "")
    policy      = string
  }))
  default = {}
}

variable "inline_policies" {
  description = "Inline policies to embed directly in this role"
  type = map(object({
    policy = string
  }))
  default = {}
}

variable "managed_policy_arns" {
  description = "ARNs of pre-existing policies (AWS managed or cross-stack) to attach to this role"
  type        = list(string)
  default     = []
}

variable "create_instance_profile" {
  description = "Whether to create an IAM instance profile wrapping this role (required for EC2/EKS node roles)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to merge with common tags"
  type        = map(string)
  default     = {}
}
