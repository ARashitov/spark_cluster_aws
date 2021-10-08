variable "region" {
  type = string
}

variable "name" {
  description = "Name of project"
  type = string
}

variable "vpc_id" {
  type = string
}

variable ami {
  type        = string
}

variable ssh_key {
  type        = string
  default     = ""
  description = "ssh keys for access to aws"
}

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

# variable "workers_subnets" {
#   description = "Private subnet where workers need to be located"
#   type = list
# }