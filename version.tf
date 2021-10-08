terraform {
  required_version = ">= 0.12.26"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 2.7.0"
    }
  }
  backend "s3" {
    bucket  = "dev-terraform-dask"
    key     = "services/waste-labs-rds/services/vpc/terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}