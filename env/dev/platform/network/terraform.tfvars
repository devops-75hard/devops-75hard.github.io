vpcs = {
  vpc1 = {
    cidr_block = "10.0.0.0/16"
    name       = "vpc1"
    tags = {
      Team      = "platform"
      Component = "network"
    }
    public_subnets = {
      "public-1a" = {
        cidr_block        = "10.0.0.0/24"
        availability_zone = "ap-south-1a"
      }
      "public-1b" = {
        cidr_block        = "10.0.1.0/24"
        availability_zone = "ap-south-1b"
      }
    }
    private_subnets = {
      "private-1a" = {
        cidr_block        = "10.0.2.0/24"
        availability_zone = "ap-south-1a"
        nat_gateway       = "public-1a" # NAT lives in this public subnet
      }
      "private-1b" = {
        cidr_block        = "10.0.3.0/24"
        availability_zone = "ap-south-1b"
        # no nat_gateway = fully private, no internet route
      }
    }
  }
}
