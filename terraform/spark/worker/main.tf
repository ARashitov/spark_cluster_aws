locals {
  module_name = join("-", [var.project_name, var.env, "worker"])
  user_data   = <<EOF
#!/bin/bash
echo "
docker run -d -e SPARK_MASTER=spark://${var.master_private_ip}:7077 -p 8081:8081 --name spark-worker ${var.worker_image}
" > /home/ubuntu/docker-init.sh;
sleep 15;
source /home/ubuntu/docker-init.sh;
EOF
}


module "spark_worker" {


  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">= 4.1.0, < 5.0.0"

  count = var.workers_count

  name = local.module_name

  create_spot_instance = true

  spot_price                          = "0.60"
  spot_wait_for_fulfillment           = true
  spot_type                           = "persistent"
  spot_instance_interruption_behavior = "terminate"

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  monitoring    = true

  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  private_ip                  = var.workers_private_ip[count.index]

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

  tags = {
    "spark" : "worker"
  }

}
