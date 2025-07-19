variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "container_image" {
  description = "Docker image for ECS task"
  type        = string
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}

variable "vpc_id" {
  description = "VPC ID for ECS service"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "execution_role_arn" {
  description = "IAM role ARN for ECS task execution"
  type        = string
}

variable "task_role_arn" {
  description = "IAM role ARN for ECS task"
  type        = string
}

variable "alb_target_group_arn" {
  description = "Target group ARN for ECS service"
  type        = string
}

variable "alb_sg_id" {
  description = "Security group ID of the ALB"
  type        = string
}


variable "alb_listener_arn" {
  description = "Listener ARN for ALB"
  type        = string
}
