cluster_name       = "cluster"
kubernetes_version = "1.34"

node_groups = {
  standard-workers = {
    instance_types = ["t3.medium"]
    desired_size   = 2
    min_size       = 1
    max_size       = 4
  }
}

tags = {
  Team      = "platform"
  Component = "eks"
}
