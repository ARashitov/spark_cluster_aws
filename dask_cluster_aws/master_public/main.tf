provider "aws" {
  region = var.region
}


module "master_sg" {

  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4"

  name        = var.name
  description = "opening ssh access to ec2 instance"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH tunnel to database"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Access to whole infrastructure"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

}


module "dask_master"{
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = var.name
  instance_count         = 1

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.ssh_key
  monitoring             = true


  vpc_security_group_ids = [module.master_sg.security_group_id]
  subnet_id              = var.subnet_id
  associate_public_ip_address = false

  root_block_device = [
        {
            encrypted   = true
            volume_type = "gp3"
            throughput  = 200
            volume_size = 30
        },
    ]
}

resource "aws_eip_association" "dask_master_ip_association" {
  instance_id   = module.dask_master.id[0]
  allocation_id = var.master_public_ip
}