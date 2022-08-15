provider "aws" {
  region = data.terraform_remote_state.vpc.outputs.region
}

locals {

  project_name = data.terraform_remote_state.vpc.outputs.project_name
  env          = terraform.workspace

  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr_block     = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
  public_subnet_id   = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  public_subnet_cidr = data.terraform_remote_state.vpc.outputs.public_subnets_cidr_blocks[0]

  key_pair = var.key_pair
}


resource "aws_emr_cluster" "spark_cluster" {

  name          = "${local.env}-${local.project_name}"
  release_label = var.release_label
  service_role  = aws_iam_role.iam_emr_service_role.arn
  applications  = var.applications

  ec2_attributes {
    subnet_id                         = local.public_subnet_id
    emr_managed_master_security_group = module.security_group_spark.security_group_id
    emr_managed_slave_security_group  = module.security_group_spark.security_group_id
    instance_profile                  = aws_iam_instance_profile.emr_profile.arn
    key_name                          = local.key_pair
  }

  master_instance_fleet {
    instance_type_configs {
      instance_type = var.master_instance_type
    }
    target_on_demand_capacity = 1
  }

  core_instance_fleet {
    instance_type_configs {
      bid_price_as_percentage_of_on_demand_price = 60
      ebs_config {
        size                 = 100
        type                 = "gp2"
        volumes_per_instance = 1
      }
      instance_type     = var.worker_instance_type
      weighted_capacity = 1
    }
    name                 = "${local.env} core fleet ${local.project_name}"
    target_spot_capacity = var.workers_count
  }
}

module "security_group_spark" {

  source  = "terraform-aws-modules/security-group/aws"
  version = ">= 4.9.0, < 5.0.0"

  name        = "${local.env}-${local.project_name}-spark"
  description = "EMR Spark cluster security group"
  vpc_id      = local.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH tunnel to database"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Access to whole infrastructure"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
###

# IAM Role setups

###

# IAM role for EMR Service
resource "aws_iam_role" "iam_emr_service_role" {
  name = "iam_emr_service_role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticmapreduce.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "iam_emr_service_policy" {
  name = "iam_emr_service_policy"
  role = aws_iam_role.iam_emr_service_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Resource": "*",
        "Action": [
            "ec2:AuthorizeSecurityGroupEgress",
            "ec2:AuthorizeSecurityGroupIngress",
            "ec2:CancelSpotInstanceRequests",
            "ec2:CreateNetworkInterface",
            "ec2:CreateSecurityGroup",
            "ec2:CreateTags",
            "ec2:DeleteNetworkInterface",
            "ec2:DeleteSecurityGroup",
            "ec2:DeleteTags",
            "ec2:DescribeAvailabilityZones",
            "ec2:DescribeAccountAttributes",
            "ec2:DescribeDhcpOptions",
            "ec2:DescribeInstanceStatus",
            "ec2:DescribeInstances",
            "ec2:DescribeKeyPairs",
            "ec2:DescribeNetworkAcls",
            "ec2:DescribeNetworkInterfaces",
            "ec2:DescribePrefixLists",
            "ec2:DescribeRouteTables",
            "ec2:DescribeSecurityGroups",
            "ec2:DescribeSpotInstanceRequests",
            "ec2:DescribeSpotPriceHistory",
            "ec2:DescribeSubnets",
            "ec2:DescribeVpcAttribute",
            "ec2:DescribeVpcEndpoints",
            "ec2:DescribeVpcEndpointServices",
            "ec2:DescribeVpcs",
            "ec2:DetachNetworkInterface",
            "ec2:ModifyImageAttribute",
            "ec2:ModifyInstanceAttribute",
            "ec2:RequestSpotInstances",
            "ec2:RevokeSecurityGroupEgress",
            "ec2:RunInstances",
            "ec2:TerminateInstances",
            "ec2:DeleteVolume",
            "ec2:DescribeVolumeStatus",
            "ec2:DescribeVolumes",
            "ec2:DetachVolume",
            "iam:GetRole",
            "iam:GetRolePolicy",
            "iam:ListInstanceProfiles",
            "iam:ListRolePolicies",
            "iam:PassRole",
            "s3:CreateBucket",
            "s3:Get*",
            "s3:List*",
            "sdb:BatchPutAttributes",
            "sdb:Select",
            "sqs:CreateQueue",
            "sqs:Delete*",
            "sqs:GetQueue*",
            "sqs:PurgeQueue",
            "sqs:ReceiveMessage"
        ]
    }]
}
EOF
}

# IAM Role for EC2 Instance Profile
resource "aws_iam_role" "iam_emr_profile_role" {
  name = "iam_emr_profile_role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "emr_profile" {
  name = "emr_profile"
  role = aws_iam_role.iam_emr_profile_role.name
}

resource "aws_iam_role_policy" "iam_emr_profile_policy" {
  name = "iam_emr_profile_policy"
  role = aws_iam_role.iam_emr_profile_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Resource": "*",
        "Action": [
            "cloudwatch:*",
            "dynamodb:*",
            "ec2:*",
            "elasticmapreduce:*",
            "kinesis:*",
            "rds:*",
            "s3:*",
            "sdb:*",
            "sns:*",
            "sqs:*"
        ]
    }]
}
EOF
}
