output "ecs_cluster_id" {
  description = "The ECS Cluster ID"
  value       = aws_ecs_cluster.this.id
}

output "ecs_task_definition_arn" {
  description = "The ECS Task Definition ARN"
  value       = aws_ecs_task_definition.this.arn
}

output "ecs_service_name" {
  description = "The ECS Service Name"
  value       = aws_ecs_service.this.name
}
