variable "key_pair" {
  type        = string
  default     = "aws-us-east-2"
  description = "aws instance key used for ssh"
}

variable "master_instance_type" {
  type        = string
  default     = "c5a.large"
  description = "Master node instance type"
}

variable "worker_instance_type" {
  type        = string
  default     = "c5a.large"
  description = "Master node instance type"
}

variable "workers_count" {
  type        = number
  default     = 3
  description = "Worker instance count"
}


variable "master_image" {
  type        = string
  default     = "bde2020/spark-master:3.3.0-hadoop3.3"
  description = "Master node docker image"
}

variable "worker_image" {
  type        = string
  default     = "bde2020/spark-worker:3.3.0-hadoop3.3"
  description = "Worker node docker image"
}

variable "master_user_data" {
  type        = string
  description = "Spark master node user data parameters"
  default     = <<EOF
#!/bin/bash
echo "
docker run \
  -d \
  -e INIT_DAEMON_STEP=setup_spark \
  -p 8080:8080 -p 7077:7077 \
  --name spark-master \
  bde2020/spark-master:3.3.0-hadoop3.3
" > /home/ubuntu/docker-init.sh;
source /home/ubuntu/docker-init.sh;
EOF
}


variable "worker_user_data" {
  type        = string
  description = "Spark worker node user data parameters"
  default     = <<EOF
#!/bin/bash
echo "
docker run \
  -d \
  -e INIT_DAEMON_STEP=setup_spark \
  -p 8080:8080 -p 7077:7077 \
  --name spark-master \
  bde2020/spark-master:3.3.0-hadoop3.3
" > /home/ubuntu/docker-init.sh;
sleep 20;
source /home/ubuntu/docker-init.sh;
EOF
}
