output "master" {
  value       = "1 * ${var.master_instance_type}"
  description = "Master node spark cluster config"
}

output "workers" {
  value       = "${var.workers_count} * ${var.worker_instance_type}"
  description = "Worker nodes spark cluster config"
}

output "master_connection" {
  value       = "spark://${module.master_node.public_ip}:7077"
  description = "Master node private ip"
}

output "master_private_ip" {
  value       = local.master_private_ip
  description = "Private IPv4 of spark master node"
}

output "workers_private_ip" {
  value       = local.workers_private_ip
  description = "Private IPv4 of spark worker node"
}
