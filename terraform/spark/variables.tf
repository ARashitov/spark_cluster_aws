variable "key_pair" {
  type        = string
  default     = "aws-us-east-2"
  description = "aws instance key used for ssh"
}

variable "master_instance_type" {
  type        = string
  default     = "m5a.large"
  description = "Master node instance type"
}

variable "worker_instance_type" {
  type        = string
  default     = "m5a.large"
  description = "Master node instance type"
}

variable "workers_count" {
  type        = number
  default     = 2
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
