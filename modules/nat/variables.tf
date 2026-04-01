variable "public_subnet_id" {
  type = string
}

variable "igw_id" {
  description = "Internet Gateway ID — used to ensure IGW exists before NAT is created"
  type        = string
}

variable "name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
