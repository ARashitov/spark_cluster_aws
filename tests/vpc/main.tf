provider "aws" {
  region = var.region
}


module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2"

  name = var.name

  cidr = "10.99.0.0/18"
  azs              = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets   = ["10.99.0.0/24"]
  private_subnets = ["10.99.7.0/24", "10.99.8.0/24", "10.99.9.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

}

resource "aws_eip" "master_ip" {
  vpc              = true
  tags = {
    Name = "dask_cluster_master_${var.region}"
  }
}