# == COMMON PARAMETERS ==
variable ami {
  description = "AMI image used for bastion instance"
  type = string
  default = "ami-0b4d44f0f68cb30bc"
}

variable ssh_key {
  type        = string
  default     = "waste-labs-dev-london-eu-west-2"
  description = "ssh key for access to servers"
}

# == MASTER NODE PARAMETERS ==
variable master_instance_type {
  type        = string
  default     = "t2.micro"
  description = "description"
}

variable fpath_user_data_master {
  type        = string
  default     = "/Users/atmosphere/Projects/DEV_terraform_dask/tests/dask_cluster_aws/initialization/start_master.sh"
  description = "Starting script for master node"
}

# == WORKER NODES PARAMETERS ==
variable n_workers {
  type        = number
  default     = 1
  description = "Amount of worker nodes to spin up"
}

variable workers_instance_type {
  type        = string
  default     = "t2.micro"
  description = "Instance type of workers to spin up"
}

variable fpath_user_data_workers {
  type        = string
  default     = "/Users/atmosphere/Projects/DEV_terraform_dask/tests/dask_cluster_aws/initialization/start_worker.sh"
  description = "Starting script for workers nodes"
}
