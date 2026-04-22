locals {
  env          = "dev"
  prefix       = "75hardevops"
  region       = "us-east-1"
  iam_role_arn = "arn:aws:iam::576415573462:role/admin-role"
  session_name = "75hardevops-TerraformSession"
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket  = "terraform-bucket-576415573462-us-east-1-an"
    key     = "75hardevops-dev-network-statefile"
    region  = "us-east-1"
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"
  config = {
    bucket  = "terraform-bucket-576415573462-us-east-1-an"
    key     = "75hardevops-dev-iam-statefile"
    region  = "us-east-1"
  }
}
