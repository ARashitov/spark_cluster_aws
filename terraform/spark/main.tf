provider "aws" {
  region = data.terraform_remote_state.vpc.outputs.region
}

locals {
  env = terraform.workspace

  project_name   = data.terraform_remote_state.vpc.outputs.project_name
  vpc_id         = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr_block = data.terraform_remote_state.vpc.outputs.vpc_cidr_block

  key_pair                  = var.key_pair
  public_subnet_id          = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  public_subnet_cidr        = data.terraform_remote_state.vpc.outputs.public_subnets_cidr_blocks[0]
  default_security_group_id = data.terraform_remote_state.vpc.outputs.default_security_group_id

  master_tail_octect = 5

  subnet_split_cidr         = split(".", local.public_subnet_cidr)
  subnet_split_head_octects = slice(local.subnet_split_cidr, 0, 3)
  master_private_ip         = "${join(".", local.subnet_split_head_octects)}.${local.master_tail_octect}"

  worker_start_ip = sum([local.master_tail_octect, 1])
  workers_end_ip  = sum([local.master_tail_octect, var.workers_count, 1])
  workers_private_ip = [
    for worker_id in range(local.worker_start_ip, local.workers_end_ip) :
    "${join(".", local.subnet_split_head_octects)}.${worker_id}"
  ]

}


module "master_node" {

  source = "./master/"

  project_name = local.project_name
  vpc_id       = local.vpc_id
  env          = local.env

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.master_instance_type
  key_name      = var.key_pair

  subnet_id         = local.public_subnet_id
  subnet_cidr       = local.public_subnet_cidr
  master_image      = var.master_image
  master_private_ip = local.master_private_ip
}


module "worker_node" {

  source     = "./worker/"
  depends_on = [module.master_node]

  project_name = local.project_name
  vpc_id       = local.vpc_id
  env          = local.env

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.master_instance_type
  key_name      = var.key_pair

  subnet_id   = local.public_subnet_id
  subnet_cidr = local.public_subnet_cidr

  workers_count     = var.workers_count
  worker_image      = var.worker_image
  security_group_id = local.default_security_group_id

  master_private_ip  = module.master_node.private_ip
  workers_private_ip = local.workers_private_ip
}
