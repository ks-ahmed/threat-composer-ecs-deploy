variable "name_prefix" {
  description = "Prefix for IAM role names"
  type        = string
}

variable "execution_role_name" {
  description = "Name suffix for ECS task execution role"
  type        = string
  default     = "ecs-exec-role"
}

variable "task_role_name" {
  description = "Name suffix for ECS task role"
  type        = string
  default     = "ecs-task-role"
}

variable "execution_policy_arn" {
  description = "IAM policy ARN to attach to the execution role"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

variable "ecs_service_principal" {
  type        = string
  description = "Service principal for ECS task assume role policy"
  default     = "ecs-tasks.amazonaws.com"
}

locals {
  assume_role_version = "2012-10-17"
  assume_role_action = "sts:AssumeRole"
  assume_role_effect = "Allow"

}
