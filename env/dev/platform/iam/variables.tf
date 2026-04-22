variable "roles" {
  description = "Map of IAM role configurations"
  type = map(object({
    name                    = string
    assume_role_policy      = string
    create_instance_profile = optional(bool, false)
    managed_policy_arns     = optional(list(string), [])
    policies = optional(map(object({
      description = optional(string, "")
      policy      = string
    })), {})
    inline_policies = optional(map(object({
      policy = string
    })), {})
    tags = optional(map(string), {})
  }))
}
