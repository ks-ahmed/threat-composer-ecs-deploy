variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "task_family" {
  description = "Name of the ECS task family"
  type        = string
}

variable "image_url" {
  description = "Docker image URL to deploy"
  type        = string
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}

variable "subnets" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security Group ID to assign to ECS tasks (usually ALB SG)"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the ALB target group to register the ECS service"
  type        = string
}
