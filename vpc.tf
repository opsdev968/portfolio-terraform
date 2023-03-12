data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "${var.OWNERTAG}-vpc"
  cidr = var.cidr_block

  azs             = data.aws_availability_zones.available.names  #["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = var.private_subnet_cidr_blocks #["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = var.public_subnet_cidr_blocks  #["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]


  #private_subnet_tags = var.private_subnet_tags
  #public_subnet_tags = var.public_subnet_tags

  one_nat_gateway_per_az = false

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = var.tag_environment
  }
}


