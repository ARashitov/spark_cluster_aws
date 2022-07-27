provider "aws" {
  region = var.region
}


module "workers_sg" {

  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4"

  name        = var.name
  description = "Security group for workers"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Access to whole VPC infrastructure"
      cidr_blocks = "${var.vpc_cidr}"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Access over SSH"
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


module "dask_workers"{


  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"


  name                   = var.name
  instance_count         = var.n_workers

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.ssh_key
  monitoring             = true

  vpc_security_group_ids = [module.workers_sg.security_group_id]
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

  user_data = <<EOF
#!/bin/bash

echo "version: \"3.1\"

services:

  worker:
    image: daskdev/dask:2021.9.1-py3.8
    network_mode: host
    command: [\"dask-worker\", \"tcp://${join(".", slice(split(".", var.master_subnet_cidr), 0, 3))}.5:8786\"]" > docker-compose.yaml;

sudo docker-compose -f docker-compose.yaml up -d;
EOF

}
