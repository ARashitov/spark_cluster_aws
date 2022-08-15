output "master_public_dns" {
  value       = aws_emr_cluster.spark_cluster.master_public_dns
  description = "Spark master node public dns"

}
