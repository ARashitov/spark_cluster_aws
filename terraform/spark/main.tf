provider "aws" {
  region = data.terraform_remote_state.vpc.outputs.region
}

locals {
  env = terraform.workspace

  project_name   = data.terraform_remote_state.vpc.outputs.project_name
  vpc_id         = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr_block = data.terraform_remote_state.vpc.outputs.vpc_cidr_block

  key_pair           = var.key_pair
  public_subnet_id   = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  public_subnet_cidr = data.terraform_remote_state.vpc.outputs.public_subnets_cidr_blocks[0]

}


module "master_node" {

  source = "./master/"

  project_name = local.project_name
  vpc_id       = local.vpc_id
  env          = local.env

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.master_instance_type
  key_name      = var.key_pair

  subnet_id    = local.public_subnet_id
  subnet_cidr  = local.public_subnet_cidr
  master_image = var.master_image

}


# module "dask_workers" {

#   source = "./worker/"

#   project_name = local.project_name
#   vpc_id       = local.vpc_id
#   env          = local.env

#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.master_instance_type[terraform.workspace]
#   key_name      = var.key_pair
#   workers_count = var.workers_count[terraform.workspace]

#   master_private_ip = module.master_node.master_node_private_ip
#   subnet_id         = local.subnets_ids[0]
#   subnet_cidr       = local.subnets_cidr[0]

# }
