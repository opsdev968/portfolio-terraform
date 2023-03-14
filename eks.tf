module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "${var.OWNERTAG}-eks-cluster"
  cluster_version = "1.25"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  eks_managed_node_group_defaults = {
    disk_size = 50
  }

  eks_managed_node_groups = {
    general = {
      desired_size = 3
      min_size     = 3
      max_size     = 10

      labels = {
        role = "general"
      }

      instance_types = ["${var.eks_machine_type}"]
      capacity_type  = "ON_DEMAND"
    }

    spot = {
      desired_size = 3
      min_size     = 3
      max_size     = 10

      labels = {
        role = "spot"
      }

      taints = [{
        key    = "market"
        value  = "spot"
        effect = "NO_SCHEDULE"
      }]

      instance_types = ["${var.eks_machine_type}"]
      capacity_type  = "SPOT"
    }
  }

  tags = {
    #Environment = var.tag_environment
    Terraform   = "true"
    #Name = var.OWNERTAG
  }
}