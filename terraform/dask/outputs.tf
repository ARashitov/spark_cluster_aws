output "output_master" {
  value       = module.dask_workers.workers_public_ip
  description = "Private IPs of worker nodes"
}
