variable "container_image" {
  type        = string
  description = "The container image to deploy"
}

variable "execution_role_arn" {
  type        = string
  description = "IAM role for ECS task execution"
}

variable "task_role_arn" {
  type        = string
  description = "IAM role for ECS task"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnets for ECS tasks"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for ECS service and security group"
}

variable "alb_target_group_arn" {
  type        = string
  description = "ARN of the target group in ALB"
}

variable "alb_security_group_id" {
  type        = string
  description = "Security group ID of ALB"
}
