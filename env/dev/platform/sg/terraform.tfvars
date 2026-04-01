vpc_name = "vpc1"

security_groups = {

  "common" = {
    description = "Common Platform SG: SSH from VPC, all traffic from public and private SG"
    ingress_rules = {
      "ssh" = {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
      "from-public" = {
        from_port      = 0
        to_port        = 0
        protocol       = "-1"
        source_sg_key  = "public"
      }
      "from-private" = {
        from_port      = 0
        to_port        = 0
        protocol       = "-1"
        source_sg_key  = "private"
      }
    }
    egress_rules = {
      "all" = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }

  "public" = {
    description = "Public Load Balancer SG: 80/443 open to internet"
    ingress_rules = {
      "http" = {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      "https" = {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
    egress_rules = {
      "all" = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }

  "private" = {
    description = "Private SG: 80/443 restricted to VPC CIDR only"
    ingress_rules = {
      "http" = {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
      "https" = {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    }
    egress_rules = {
      "all" = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }

}
