provider "aws" {
  region = var.tags.region
}

locals {
  n_subnet_per_env = var.n_subnets_per_environment
  n_envs           = length(var.environments)
  n_total_subnets  = local.n_envs * local.n_subnet_per_env
}


module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "= 3.14.0"

  name = var.tags.project_name
  cidr = "10.99.0.0/18"

  azs = ["${var.tags.region}a", "${var.tags.region}b", "${var.tags.region}c"]

  public_subnets = [for subnet_id in range(0, local.n_total_subnets) : "10.99.${subnet_id}.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  manage_default_security_group = true
  default_security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow entire egress traffic"
    }
  ]
  default_security_group_ingress = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow ssh ingress traffic"
    },
  ]

  tags = merge(
    var.tags,
    {
      environment = terraform.workspace,
  })
}
