output "private_ip" {
  value       = module.spark_master.private_ip
  description = "Master node private ip address"
}

output "public_ip" {
  value       = module.spark_master.public_ip
  description = "Master node public ip address"
}
