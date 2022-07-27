output "workers_public_ip" {
  value = module.dask_worker[*].public_ip
}
