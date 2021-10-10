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
  description = "Subnet id where bastion must be deployed"  
}

variable ssh_key {
  type        = string
  default     = ""
  description = "ssh keys for access to aws"
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