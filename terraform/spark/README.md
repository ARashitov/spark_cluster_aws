<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.8, < 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.26.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.26.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_master_node"></a> [master\_node](#module\_master\_node) | ./master/ | n/a |
| <a name="module_worker_node"></a> [worker\_node](#module\_worker\_node) | ./worker/ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | aws instance key used for ssh | `string` | `"aws-us-east-2"` | no |
| <a name="input_master_image"></a> [master\_image](#input\_master\_image) | Master node docker image | `string` | `"bde2020/spark-master:3.3.0-hadoop3.3"` | no |
| <a name="input_master_instance_type"></a> [master\_instance\_type](#input\_master\_instance\_type) | Master node instance type | `string` | `"m5a.large"` | no |
| <a name="input_worker_image"></a> [worker\_image](#input\_worker\_image) | Worker node docker image | `string` | `"bde2020/spark-worker:3.3.0-hadoop3.3"` | no |
| <a name="input_worker_instance_type"></a> [worker\_instance\_type](#input\_worker\_instance\_type) | Master node instance type | `string` | `"m5a.large"` | no |
| <a name="input_workers_count"></a> [workers\_count](#input\_workers\_count) | Worker instance count | `number` | `6` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master"></a> [master](#output\_master) | Master node spark cluster config |
| <a name="output_master_connection"></a> [master\_connection](#output\_master\_connection) | Master node private ip |
| <a name="output_master_private_ip"></a> [master\_private\_ip](#output\_master\_private\_ip) | Private IPv4 of spark master node |
| <a name="output_workers"></a> [workers](#output\_workers) | Worker nodes spark cluster config |
| <a name="output_workers_private_ip"></a> [workers\_private\_ip](#output\_workers\_private\_ip) | Private IPv4 of spark worker node |
<!-- END_TF_DOCS -->
