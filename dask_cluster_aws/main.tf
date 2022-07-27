provider "aws" {
  region = var.region
}


module "dask_master" {

  source  = "./master_public/"
  
  region = var.region
  name = var.name
  ami = var.ami
  instance_type = var.master_instance_type
  vpc_id = var.vpc_id
  subnet_id = var.master_subnet
  ssh_key = var.ssh_key
  master_public_ip = var.master_public_ip
  fpath_user_data = var.fpath_user_data_master
  vpc_cidr = var.vpc_cidr
  subnet_cidr = var.master_subnet_cidr

}


module "dask_workers" {

  source  = "./worker/"
  
  region = var.region
  name = var.name
  ami = var.ami
  vpc_id = var.vpc_id
  vpc_cidr = var.vpc_cidr
  ssh_key = var.ssh_key

  master_subnet_cidr = var.master_subnet_cidr
  subnet_id = var.workers_subnet
  instance_type = var.workers_instance_type
  fpath_user_data = var.fpath_user_data_workers

}
