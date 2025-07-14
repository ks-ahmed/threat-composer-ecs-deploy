resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.name_prefix}-${var.execution_role_name}"

  assume_role_policy = jsonencode({
    Version = local.assume_role_version
    Statement = [
      {
        Action = local.assume_role_action
        Principal = {
          Service = var.ecs_service_principal
        }
        Effect = local.assume_role_effect
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = var.execution_policy_arn
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${var.name_prefix}-${var.task_role_name}"

  assume_role_policy = jsonencode({
    Version = local.assume_role_version
    Statement = [
      {
        Action = local.assume_role_action
        Principal = {
          Service = var.ecs_service_principal
        }
        Effect = local.assume_role_effect
        Sid    = ""
      }
    ]
  })
}
