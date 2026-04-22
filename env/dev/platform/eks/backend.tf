terraform {
  backend "s3" {
    bucket  = "terraform-bucket-576415573462-us-east-1-an"
    key     = "75hardevops-dev-eks-statefile"
    region  = "us-east-1"
    encrypt = true
  }
}
