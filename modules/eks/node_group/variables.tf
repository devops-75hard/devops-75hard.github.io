variable "cluster_name" {
  type = string
}

variable "name" {
  type = string
}

variable "node_role_arn" {
  description = "ARN of the IAM role for EKS worker nodes"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs to launch nodes into"
  type        = list(string)
}

variable "instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "ami_type" {
  description = "AL2023_x86_64_STANDARD for standard nodes"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "capacity_type" {
  description = "ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"
}

variable "desired_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "tags" {
  type    = map(string)
  default = {}
}
