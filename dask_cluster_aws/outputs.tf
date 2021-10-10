output workers_private_ip {
  value       = module.dask_workers.private_ip
  description = "Private IPv4 addresses of workers"
}
