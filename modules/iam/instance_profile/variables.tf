variable "name" {
  type = string
}

variable "role" {
  description = "Name of the IAM role to associate with this instance profile"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
