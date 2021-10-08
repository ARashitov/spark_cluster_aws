provider "aws" {
  region = var.region
}


module "dask_cluster" {

  source  = "../../dask_cluster_aws/"

  # Common EC2 configs
  region = data.terraform_remote_state.vpc.outputs.region
  name = data.terraform_remote_state.vpc.outputs.name
  ami = var.ami
  ssh_key = var.ssh_key

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  # Master node config
  master_instance_type = var.master_instance_type  
  master_subnet = data.terraform_remote_state.vpc.outputs.public_subnets[0] 
  master_public_ip = data.terraform_remote_state.vpc.outputs.allocated_aws_eip_id

}
