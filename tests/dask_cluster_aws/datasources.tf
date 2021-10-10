data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "dev-terraform-dask"
    key     = "services/dask/dask_cluster_vpc.tfstate"
    region  = "ap-southeast-1"
  }
}