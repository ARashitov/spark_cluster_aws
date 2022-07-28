<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.8, < 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 4.9.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | = 3.14.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environments"></a> [environments](#input\_environments) | Application environments | `list(string)` | <pre>[<br>  "dev",<br>  "test",<br>  "prod"<br>]</pre> | no |
| <a name="input_n_subnets_per_environment"></a> [n\_subnets\_per\_environment](#input\_n\_subnets\_per\_environment) | Amount of private subnets per environment | `number` | `2` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags set to VPC | `map(string)` | <pre>{<br>  "project_name": "dask-cluster",<br>  "region": "us-east-2"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azs"></a> [azs](#output\_azs) | A list of availability zones specified as argument to this module |
| <a name="output_default_security_group_id"></a> [default\_security\_group\_id](#output\_default\_security\_group\_id) | VPC default security group id |
| <a name="output_default_vpc_cidr_block"></a> [default\_vpc\_cidr\_block](#output\_default\_vpc\_cidr\_block) | The CIDR block of the Default VPC |
| <a name="output_default_vpc_default_security_group_id"></a> [default\_vpc\_default\_security\_group\_id](#output\_default\_vpc\_default\_security\_group\_id) | Default security group name |
| <a name="output_environments"></a> [environments](#output\_environments) | Application environments |
| <a name="output_n_private_subnets_per_environment"></a> [n\_private\_subnets\_per\_environment](#output\_n\_private\_subnets\_per\_environment) | Amount of private subnets per environment |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | EC2 instances private subnet |
| <a name="output_private_subnets_cidr_blocks"></a> [private\_subnets\_cidr\_blocks](#output\_private\_subnets\_cidr\_blocks) | EC2 instances private CIDR blocks |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | EC2 instances public subnet |
| <a name="output_public_subnets_cidr_blocks"></a> [public\_subnets\_cidr\_blocks](#output\_public\_subnets\_cidr\_blocks) | EC2 instances public CIDR blocks |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags assigned to project |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | VPC CIDR blocks |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC id |
<!-- END_TF_DOCS -->
