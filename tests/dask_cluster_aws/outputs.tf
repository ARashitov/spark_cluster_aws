output master_node_public_ip_id {
  value       = data.terraform_remote_state.vpc.outputs.allocated_aws_eip_id
}

output master_node_public_ip {
  value       = data.terraform_remote_state.vpc.outputs.allocated_public_ip
}

output private_ip_worker_nodes {
  value       = module.dask_cluster.workers_private_ip
}
