variable "name" {
  type = string
}

variable "role" {
  description = "Name of the IAM role to attach this policy to"
  type        = string
}

variable "policy" {
  type = string
}
