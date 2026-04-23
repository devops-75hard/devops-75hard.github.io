clusters = {
  cluster1 = {
    name               = "cluster"
    kubernetes_version = "1.34"
    role_arn_key       = "eks-cluster"
    node_role_arn_key  = "eks-node"
    vpc_key            = "vpc1"
    subnet_keys        = ["private-1a", "private-1b"]
    security_group_ids = []
    node_groups = {
      standard-workers = {
        instance_types = ["t3.medium", "t3a.medium"]
        ami_type       = "AL2023_x86_64_STANDARD"
        capacity_type  = "ON_DEMAND"
        desired_size   = 2
        min_size       = 1
        max_size       = 4
      }
    }
    addons = {
      "eks-pod-identity-agent" = {
        version = null
      }
    }
    tags = {
      Team      = "platform"
      Component = "eks"
    }
  }
}
