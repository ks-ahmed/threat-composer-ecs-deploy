output "task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "task_role_arn" {
  value = var.create_task_role ? aws_iam_role.ecs_task_role[0].arn : null
}
