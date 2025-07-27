variable "name" {
  description = "Prefix for IAM role names (e.g. app name or environment)"
  type        = string
}

variable "execution_policy_arn" {
  description = "ARN of the IAM policy to attach to the ECS execution role"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
