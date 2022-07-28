data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["946627858531"]

  filter {
    name   = "name"
    values = ["ubuntu-22.04"]
  }

}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "waste-labs-terraform-backends"
    key    = "env:/shared/dask_cluster_aws/vpc.tfstate"
    region = "us-east-1"
  }
}
