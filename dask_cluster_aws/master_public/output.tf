output private_ip_master {
  value       = module.dask_master.private_ip[0]
  description = "Private IP of master"
}
