######################################################## VPC ########################################################

vpcs = {
  "vpc1" = {
    cidr_block = "10.0.0.0/16"

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
      }
      "private-1b" = {
        cidr_block        = "10.0.3.0/24"
        availability_zone = "ap-south-1b"
      }
    }
  }
}

######################################################## security_groups ########################################################

security_groups = {

  "loadbalancer" = {
    description = "Security group for load balancer"
    vpc_key     = "vpc1"
    tags = {
      tier  = "loadbalancer"
      owner = "devops"
    }
    ingress_rules = {
      "https" = {
        description = "HTTPS from internet"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      "http" = {
        description = "HTTP from internet"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
    egress_rules = {
      "all-out" = {
        description = "All outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }

  "common" = {
    description = "Common SG, allows SSH from internal"
    vpc_key     = "vpc1"
    tags = {
      tier  = "common"
      owner = "devops"
    }
    ingress_rules = {
      "ssh" = {
        description = "SSH from internal"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/8"]
      }
    }
    egress_rules = {
      "all-out" = {
        description = "All outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }

  "application1" = {
    description = "SG for application1, inbound from loadbalancer"
    vpc_key     = "vpc1"
    tags = {
      tier  = "application1"
      owner = "devops"
    }
    ingress_rules = {
      "allow-lb" = {
        description               = "Allow inbound from loadbalancer SG"
        from_port                 = 8080
        to_port                   = 8080
        protocol                  = "tcp"
        source_security_group_key = "loadbalancer"
      }
    }
    egress_rules = {
      "all-out" = {
        description = "All outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }

  "application2" = {
    description = "SG for application2, inbound from loadbalancer"
    vpc_key     = "vpc1"
    tags = {
      tier  = "application2"
      owner = "devops"
    }
    ingress_rules = {
      "allow-lb" = {
        description               = "Allow inbound from loadbalancer SG"
        from_port                 = 8080
        to_port                   = 8080
        protocol                  = "tcp"
        source_security_group_key = "loadbalancer"
      }
    }
    egress_rules = {
      "all-out" = {
        description = "All outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }

  "application3" = {
    description = "SG for application3, inbound from loadbalancer"
    vpc_key     = "vpc1"
    tags = {
      tier  = "application3"
      owner = "devops"
    }
    ingress_rules = {
      "allow-lb" = {
        description               = "Allow inbound from loadbalancer SG"
        from_port                 = 8080
        to_port                   = 8080
        protocol                  = "tcp"
        source_security_group_key = "loadbalancer"
      }
    }
    egress_rules = {
      "all-out" = {
        description = "All outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }
}

target_groups = {

  "application1" = {
    vpc_key     = "vpc1"
    target_type = "instance"
    port        = 80
    protocol    = "HTTP"
    health_check = {
      enabled             = true
      interval            = 20
      path                = "/"
      timeout             = 10
      matcher             = "200"
      protocol            = "HTTP"
      healthy_threshold   = 5
      unhealthy_threshold = 5
    }
  }

  "application2" = {
    vpc_key     = "vpc1"
    target_type = "instance"
    port        = 80
    protocol    = "HTTP"
    health_check = {
      enabled             = true
      interval            = 15
      healthy_threshold   = 5
      unhealthy_threshold = 5
    }
  }

  "app3-blue" = {
    vpc_key     = "vpc1"
    target_type = "instance"
    port        = 80
    protocol    = "HTTP"
  }

  "app3-green" = {
    vpc_key     = "vpc1"
    target_type = "instance"
    port        = 80
    protocol    = "HTTP"
  }
}


load_balancers = {

  "public-alb" = {
    internal            = false
    load_balancer_type  = "application"
    vpc_key             = "vpc1"
    subnet_keys         = ["public-1a", "public-1b"]
    security_group_keys = ["loadbalancer"]
    tags = {
      tier  = "loadbalancer"
      owner = "devops"
    }
    listeners = {
      "http-80" = {
        port     = 80
        protocol = "HTTP"
        default_action = {
          type             = "forward"
          target_group_key = "app3-green"
        }
        rules = {
          "app3-blue" = {
            priority         = 20
            host_header      = []
            path_pattern     = ["/app3/*"]
            target_groups = [
              { key = "app3-blue",  weight = 80 },
              { key = "app3-green", weight = 20 }
            ]
          }
        }
      }
    }
  }

  "internal-alb" = {
    internal            = true
    load_balancer_type  = "application"
    vpc_key             = "vpc1"
    subnet_keys         = ["private-1a", "private-1b"]
    security_group_keys = ["loadbalancer", "common"]
    tags = {
      tier  = "loadbalancer"
      owner = "devops"
    }
    listeners = {
      "http-80" = {
        port     = 80
        protocol = "HTTP"
        default_action = {
          type             = "forward"
          target_group_key = "application2"
        }
        rules = {}
      }
    }
  }
}
