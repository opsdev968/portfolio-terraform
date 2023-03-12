module "ecr" {
  source = "terraform-aws-modules/ecr/aws"
  repository_force_delete = true

  repository_name = "${var.OWNERTAG}-ecr-prv"

  #repository_read_write_access_arns = ["arn:aws:iam::644435390668:role/terraform"]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = var.tag_environment
  }
}