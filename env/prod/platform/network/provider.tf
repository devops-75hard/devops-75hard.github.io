provider "aws" {
  region = local.region

  assume_role {
    role_arn     = local.iam_role_arn
    session_name = local.session_name
  }

  default_tags {
    tags = {
      Environment = local.env
      Project     = local.prefix
      ManagedBy   = "Terraform"
    }
  }
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
