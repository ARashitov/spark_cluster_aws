<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_security_group_master"></a> [security\_group\_master](#module\_security\_group\_master) | terraform-aws-modules/security-group/aws | >= 4.9.0, < 5.0.0 |
| <a name="module_spark_master"></a> [spark\_master](#module\_spark\_master) | terraform-aws-modules/ec2-instance/aws | >= 4.1.0, < 5.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | AMI image of master node | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Project name | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key pair name to ssh | `string` | n/a | yes |
| <a name="input_master_image"></a> [master\_image](#input\_master\_image) | Master node docker image | `string` | n/a | yes |
| <a name="input_master_private_ip"></a> [master\_private\_ip](#input\_master\_private\_ip) | Master node private ip | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | n/a | yes |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | Master node subnet cidr | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Master node subnet id | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Project name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Master node private ip address |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Master node public ip address |
<!-- END_TF_DOCS -->
