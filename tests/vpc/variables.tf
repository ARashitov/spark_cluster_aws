variable "name" {
    description = "Project name for unique referencing"
  type        = string
  default     = "dask_cluster"
}

variable "region" {
  description = "Id of region service will be placed"
  type        = string
  default     = "eu-west-2"
}


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

variable master_instance_type {
  type        = string
  default     = "t2.micro"
  description = "description"
}
