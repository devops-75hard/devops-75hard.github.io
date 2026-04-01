terraform {
  backend "s3" {
    bucket  = "75hard-devops-tfstate"
    key     = "75hardevops-prod-network-statefile"
    region  = "ap-south-1"
    encrypt = true
  }
}
