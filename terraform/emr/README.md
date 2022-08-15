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
| <a name="module_security_group_spark"></a> [security\_group\_spark](#module\_security\_group\_spark) | terraform-aws-modules/security-group/aws | >= 4.9.0, < 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_emr_cluster.spark_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/emr_cluster) | resource |
| [aws_iam_instance_profile.emr_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.iam_emr_profile_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.iam_emr_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.iam_emr_profile_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.iam_emr_service_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_applications"></a> [applications](#input\_applications) | Applications to run on spark instances | `list(string)` | <pre>[<br>  "Spark"<br>]</pre> | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | aws instance key used for ssh | `string` | `"aws-us-east-2"` | no |
| <a name="input_master_image"></a> [master\_image](#input\_master\_image) | Master node docker image | `string` | `"bde2020/spark-master:3.3.0-hadoop3.3"` | no |
| <a name="input_master_instance_type"></a> [master\_instance\_type](#input\_master\_instance\_type) | Master node instance type | `string` | `"c6g.xlarge"` | no |
| <a name="input_release_label"></a> [release\_label](#input\_release\_label) | EMR cluster release label | `string` | `"emr-6.7.0"` | no |
| <a name="input_worker_image"></a> [worker\_image](#input\_worker\_image) | Worker node docker image | `string` | `"bde2020/spark-worker:3.3.0-hadoop3.3"` | no |
| <a name="input_worker_instance_type"></a> [worker\_instance\_type](#input\_worker\_instance\_type) | Master node instance type | `string` | `"c6g.xlarge"` | no |
| <a name="input_workers_count"></a> [workers\_count](#input\_workers\_count) | Worker instance count | `number` | `2` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_public_dns"></a> [master\_public\_dns](#output\_master\_public\_dns) | Spark master node public dns |
<!-- END_TF_DOCS -->
