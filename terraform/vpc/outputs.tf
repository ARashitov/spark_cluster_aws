output "project_name" {
  value       = var.project_name
  description = "Project name"
}

output "region" {
  value       = var.region
  description = "Infrastructure deployment region"
}


output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "VPC CIDR blocks"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC id"
}

output "default_vpc_cidr_block" {
  value       = module.vpc.default_vpc_cidr_block
  description = "The CIDR block of the Default VPC"
}

output "default_vpc_default_security_group_id" {
  value       = module.vpc.default_vpc_default_security_group_id
  description = "Default security group name"
}

output "azs" {
  value       = module.vpc.azs
  description = "A list of availability zones specified as argument to this module"
}


output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "EC2 instances private subnet"
}

output "private_subnets_cidr_blocks" {
  value       = module.vpc.private_subnets_cidr_blocks
  description = "EC2 instances private CIDR blocks"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "EC2 instances public subnet"
}

output "public_subnets_cidr_blocks" {
  value       = module.vpc.public_subnets_cidr_blocks
  description = "EC2 instances public CIDR blocks"
}

output "default_security_group_id" {
  value       = module.vpc.default_security_group_id
  description = "VPC default security group id"
}
