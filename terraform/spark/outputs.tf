output "worker_instance_type" {
  value       = var.worker_instance_type
  description = "worker instance type"
}

output "ami_id" {
  value       = data.aws_ami.ubuntu.id
  description = "AWS ami id"
}

output "public_cidr" {
  value       = data.terraform_remote_state.vpc.outputs.public_subnets_cidr_blocks
  description = "Public subnet CIDRs"
}
