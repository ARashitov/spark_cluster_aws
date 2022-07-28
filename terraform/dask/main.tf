provider "aws" {
  region = data.terraform_remote_state.vpc.outputs.tags.region
}

locals {
  project_name   = data.terraform_remote_state.vpc.outputs.tags.project_name
  vpc_id         = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr_block = data.terraform_remote_state.vpc.outputs.vpc_cidr_block

  key_pair = var.key_pair

  environments = data.terraform_remote_state.vpc.outputs.environments
  env_idx      = index(data.terraform_remote_state.vpc.outputs.environments, terraform.workspace)

  env = replace(terraform.workspace, "_", "-")

  n_subnets           = length(data.terraform_remote_state.vpc.outputs.public_subnets)
  amt_subnets_per_env = data.terraform_remote_state.vpc.outputs.n_subnets_per_environment
  subnets_cidr        = data.terraform_remote_state.vpc.outputs.public_subnets_cidr_blocks
  subnets_ids         = data.terraform_remote_state.vpc.outputs.public_subnets

  subnet_idx_start_env = local.env_idx * local.amt_subnets_per_env
  subnet_idx_end_env   = (local.env_idx + 1) * local.amt_subnets_per_env

  env_subnets_ids = [
    for subnet_idx_end in range(local.subnet_idx_start_env, local.subnet_idx_end_env) :
    local.subnets_ids[subnet_idx_end]
  ]
}

module "master_node" {

  source = "./master/"

  project_name = local.project_name
  vpc_id       = local.vpc_id
  env          = local.env

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.master_instance_type[terraform.workspace]
  key_name      = var.key_pair

  subnet_id   = local.subnets_ids[0]
  subnet_cidr = local.subnets_cidr[0]

}


module "dask_workers" {

  source = "./worker/"

  project_name = local.project_name
  vpc_id       = local.vpc_id
  env          = local.env

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.master_instance_type[terraform.workspace]
  key_name      = var.key_pair
  workers_count = var.workers_count[terraform.workspace]

  master_private_ip = module.master_node.master_node_private_ip
  subnet_id         = local.subnets_ids[0]
  subnet_cidr       = local.subnets_cidr[0]

}
