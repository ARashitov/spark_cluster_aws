output "tags" {
  value       = var.tags
  description = "Tags assigned to project"
}

output "environments" {
  value       = var.environments
  description = "Application environments"
}

output "n_private_subnets_per_environment" {
  value       = var.n_subnets_per_environment
  description = "Amount of private subnets per environment"
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
