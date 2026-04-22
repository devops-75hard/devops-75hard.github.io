variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = ""
}

variable "policy" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
