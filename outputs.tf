output "instance_id" {
  description = "ID da EC2 - maquina de DEV"
  value       = aws_instance.bia_dev_instance_tf.id
}

output "instance_type" {
  description = "Tipo da EC2 - maquina de DEV"
  value       = aws_instance.bia_dev_instance_tf.instance_type
}

output "instance_security_groups" {
  description = "SG da EC2 - maquina de DEV"
  value       = aws_instance.bia_dev_instance_tf.security_groups
}

output "instance_public_id" {
  description = "IP publico da EC2 - maquina de DEV"
  value       = aws_instance.bia_dev_instance_tf.public_ip
}

output "rds_endpoint" {
  description = "Endpoint do RDS da BIA"
  value       = aws_db_instance.bia.endpoint
}

output "rds_secrets" {
  description = "Cofre associado ao RDS"
  value = tolist(aws_db_instance.bia.master_user_secret)[0].secret_arn
}

output "rds_secret_name" {
  description = "Nome do cofre associado ao RDS"
  value = data.aws_secretsmanager_secret.bia_db.name
}

output "bia_repo_url" {
  description = "URL do repositorio ECR da BIA"
  value       = aws_ecr_repository.bia_tf.repository_url
}

output "alb_url" {
  description = "URL do ALB da BIA"
  value       = aws_alb.bia.dns_name
}