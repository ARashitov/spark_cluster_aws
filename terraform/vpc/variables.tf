variable "tags" {
  default = {
    project_name = "dask-cluster"
    region       = "us-east-2"
  }
  description = "Tags set to VPC"
  type        = map(string)
}

variable "environments" {
  type = list(string)
  default = [
    "dev",
    "test",
    "prod",
  ]
  description = "Application environments"
}

variable "n_subnets_per_environment" {
  type        = number
  default     = 2
  description = "Amount of private subnets per environment"
}
