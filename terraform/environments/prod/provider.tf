terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = local.region
  assume_role {
    role_arn     = local.role_arn
    session_name = "TerraformSession"
  }
}
