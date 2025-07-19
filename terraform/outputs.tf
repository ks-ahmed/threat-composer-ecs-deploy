output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = module.ecs.cluster_id
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs.service_name
}

output "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = module.ecs.ecs_task_definition_arn
}

output "ecs_security_group_id" {
  description = "ID of the ECS security group"
  value       = module.ecs.ecs_security_group_id
}

output "acm_certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = module.acm.certificate_arn
}

output "acm_domain_validation_options" {
  description = "Domain validation options from ACM"
  value       = module.acm.domain_validation_options
}

output "iam_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = module.iam.task_execution_role_arn
}

output "iam_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = module.iam.task_role_arn
}

output "validated_certificate_arn" {
  value = aws_acm_certificate_validation.acm_validation.certificate_arn
}
