variable "vpcs" {
  description = "Map of VPC configurations"
  type = map(object({
    cidr_block = string
    name       = string
    tags       = optional(map(string), {})
    public_subnets = map(object({
      cidr_block        = string
      availability_zone = string
    }))
    private_subnets = map(object({
      cidr_block        = string
      availability_zone = string
      nat_gateway       = optional(string, null) # key of the public subnet where NAT lives
    }))
  }))
}
