variable "project_name" {
  type        = string
  description = "Project name"
}


variable "vpc_id" {
  type        = string
  description = "Project name"
}


variable "env" {
  type        = string
  description = "Project name"
}

variable "ami" {
  type        = string
  description = "AMI image of master node"
}


variable "instance_type" {
  type        = string
  description = "Instance type"
}


variable "key_name" {
  type        = string
  description = "Key pair name to ssh"
}


variable "subnet_id" {
  type        = string
  description = "Master node subnet id"
}


variable "subnet_cidr" {
  type        = string
  description = "Master node subnet cidr"
}
