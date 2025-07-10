output "cluster_name" {
  value       = aws_ecs_cluster.this.name
  description = "ECS Cluster Name"
}

output "service_name" {
  value       = aws_ecs_service.this.name
  description = "ECS Service Name"
}

output "task_definition_arn" {
  value       = aws_ecs_task_definition.task.arn
  description = "ARN of ECS task definition"
}
