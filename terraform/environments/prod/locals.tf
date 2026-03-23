locals {
  env        = "prod"
  region     = "ap-south-1"
  account_id = "260621207781"
  role_arn   = "arn:aws:iam::${local.account_id}:role/75hard-devops-terraform-role-${local.env}"
}
