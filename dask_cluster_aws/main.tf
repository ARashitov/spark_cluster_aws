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
  fpath_user_data_master = var.fpath_user_data_master 
}