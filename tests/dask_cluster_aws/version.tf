terraform {
  required_version = "= 1.0.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.62.0"
    }
  }
  backend "s3" {
    bucket  = "dev-terraform-dask"
    key     = "services/dask/dask_cluster_aws.tfstate"
    region  = "ap-southeast-1"
    encrypt = true
  }
}