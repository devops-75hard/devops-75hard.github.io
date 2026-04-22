variable "cluster_name" {
  type = string
}

variable "addon_name" {
  type = string
}

variable "addon_version" {
  description = "Addon version — null lets AWS pick the latest compatible version"
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
