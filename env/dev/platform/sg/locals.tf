locals {
  env          = "dev"
  prefix       = "75hardevops"
  region       = "ap-south-1"
  iam_role_arn = "arn:aws:iam::811936640705:role/ama-terraform-role"
  session_name = "75hardevops-TerraformSession"

  # Pull VPC ID from the network stack remote state
  vpc_id = data.terraform_remote_state.network.outputs.vpc_ids[var.vpc_name]

  # Flatten all ingress rules across all SGs into one map for for_each
  # Key: "common-ssh", "public-http", etc.
  ingress_rules = merge([
    for sg_key, sg in var.security_groups : {
      for rule_key, rule in sg.ingress_rules :
      "${sg_key}-${rule_key}" => merge(rule, { sg_key = sg_key })
    }
  ]...)

  # Flatten all egress rules across all SGs into one map for for_each
  egress_rules = merge([
    for sg_key, sg in var.security_groups : {
      for rule_key, rule in sg.egress_rules :
      "${sg_key}-${rule_key}" => merge(rule, { sg_key = sg_key })
    }
  ]...)
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket  = "75hard-devops-tfstate"
    key     = "75hardevops-dev-network-statefile"
    region  = "ap-south-1"
  }
}
