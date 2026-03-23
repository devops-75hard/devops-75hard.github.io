provider "aws" {
  region = local.region
  assume_role {
    role_arn     = local.iam_role_arn
    session_name = local.session_name
  }
}
