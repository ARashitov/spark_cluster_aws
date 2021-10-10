output private_ip {
  value       = module.dask_workers.private_ip
  description = "Private IPs of worker nodes"
}
