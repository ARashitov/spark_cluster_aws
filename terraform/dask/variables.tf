variable "key_pair" {
  type        = string
  default     = "aws-us-east-2"
  description = "aws instance key used for ssh"
}

variable "master_instance_type" {
  type = map(string)
  default = {
    dev  = "c5a.large"
    test = "c5a.large"
    prod = "c5a.large"
  }
  description = "Dask master ec2 instance type"
}

variable "worker_instance_type" {
  type = map(string)
  default = {
    dev  = "c5a.large"
    test = "c5a.large"
    prod = "c5a.large"
  }
  description = "Dask worker ec2 instance type"
}

variable "workers_count" {
  type = map(number)
  default = {
    dev  = 3
    test = 2
    prod = 4
  }
  description = "Dask worker ec2 instance count"
}
