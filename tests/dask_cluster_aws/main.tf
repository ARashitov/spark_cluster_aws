provider "aws" {
  region = var.region
}


module "dask_cluster" {

  source  = "../../dask_cluster_aws/"

  # == COMMON PARAMETERS ==
  region = data.terraform_remote_state.vpc.outputs.region
  name = data.terraform_remote_state.vpc.outputs.name
  ami = var.ami
  ssh_key = var.ssh_key

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr = data.terraform_remote_state.vpc.outputs.vpc_cidr

  # == MASTER NODE PARAMETERS ==
  master_instance_type = var.master_instance_type  
  master_subnet = data.terraform_remote_state.vpc.outputs.public_subnets[0] 
  master_public_ip = data.terraform_remote_state.vpc.outputs.allocated_aws_eip_id
  fpath_user_data_master = var.fpath_user_data_master

  # == WORKER NODE PARAMETERS ==
  n_workers = var.n_workers
  workers_instance_type = var.workers_instance_type
  workers_subnet = data.terraform_remote_state.vpc.outputs.private_subnets[0]
  fpath_user_data_workers = var.fpath_user_data_workers

}
