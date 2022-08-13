locals {
  module_name = join("-", [var.project_name, var.env])
  user_data   = <<EOF
#!/bin/bash
echo "
docker run \
  -d \
  -e INIT_DAEMON_STEP=setup_spark \
  -p 8080:8080 -p 7077:7077 \
  --name spark-master \
  ${var.master_image}
" > /home/ubuntu/docker-init.sh;
source /home/ubuntu/docker-init.sh;
EOF
}

module "security_group_master" {

  source  = "terraform-aws-modules/security-group/aws"
  version = ">= 4.9.0, < 5.0.0"

  name        = local.module_name
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
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "Spark dashboard"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 7077
      to_port     = 7077
      protocol    = "tcp"
      description = "Spark master node"
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

module "spark_master" {


  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">= 4.1.0, < 5.0.0"


  name = local.module_name

  create_spot_instance = true
  ami                  = var.ami
  instance_type        = var.instance_type
  key_name             = var.key_name
  monitoring           = true

  vpc_security_group_ids      = [module.security_group_master.security_group_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 60
    },
  ]

  user_data                   = local.user_data
  user_data_replace_on_change = true

}
