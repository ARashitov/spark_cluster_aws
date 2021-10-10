# == COMMON VARIABLES ==
variable region {
  type = string
}

variable name {
  description = "Name of project"
  type = string
}

variable vpc_id {
  type = string
}

variable vpc_cidr {
  type        = string
  description = "VPC cidr"
}

variable ami {
  type        = string
  description = "AMI id image will be used for master & workers"
}

variable ssh_key {
  type        = string
  default     = ""
  description = "ssh keys for access to aws"
}

# == MASTER VARIABLES ==
variable master_instance_type {
  type        = string
  default     = ""
}

variable "master_subnet" {
  description = "Subnet of bastion instance need to be located"
  type = string
}

variable master_public_ip {
  type        = string
  default     = ""
  description = "allocated public ip for master node"
}

variable fpath_user_data_master {
  type        = string
  description = "File path to user data of master node"
}

# == WORKERS VARIABLES ==
variable n_workers {
  type        = number
  default     = 1
  description = "DASK workers count"
}

variable workers_instance_type {
  type        = string
  default     = ""
}

variable "workers_subnet" {
  description = "Subnet of bastion instance need to be located"
  type = string
}

variable fpath_user_data_workers {
  type        = string
  description = "File path to user data of master node"
}