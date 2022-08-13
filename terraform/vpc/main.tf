provider "aws" {
  region = var.region
}


module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 3.14.0, < 4.0.0"

  name = var.project_name
  cidr = "10.99.0.0/18"

  azs = ["${var.region}a"]

  public_subnets = ["10.99.0.0/18"]

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

  tags = {
    environment = terraform.workspace,
  }
}
