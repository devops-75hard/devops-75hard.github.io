terraform {
  backend "s3" {
    bucket  = "75hard-devops-tfstate"
    key     = "75hardevops-dev-network-statefile"
    region  = "ap-south-1"
    encrypt = true
  }
}
