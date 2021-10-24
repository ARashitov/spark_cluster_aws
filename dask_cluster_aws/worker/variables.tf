# == COMMON VARIABLES ==
variable region {
  type = string
}

variable name {
  type        = string
}

variable vpc_id {
  type        = string
}

variable ami {
  type        = string
}

variable instance_type {
  type        = string
  default     = ""
}


variable subnet_id {
  type = string
  description = "Subnet id of ec2 instances"  
}

variable ssh_key {
  type        = string
  default     = ""
  description = "ssh keys for access to aws"
}

variable fpath_user_data {
  type        = string
  description = "File path to user data of master node"
}

variable vpc_cidr {
  type        = string
  description = "VPC cidr"
}

variable n_workers {
  type        = number
  default     = 1
  description = "DASK workers count"
}

variable master_subnet_cidr {
  type        = string
  description = "CIDR of master subnet"
}