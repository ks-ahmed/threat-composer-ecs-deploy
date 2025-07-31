variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "ecs-cluster"
}

variable "ecs_task_family" {
  description = "Family name of the ECS task definition"
  type        = string
  default     = "ecs-app"
}

variable "ecs_task_cpu" {
  description = "CPU units for the ECS task"
  type        = string
  default     = "256"
}

variable "ecs_task_memory" {
  description = "Memory for the ECS task"
  type        = string
  default     = "512"
}

variable "execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "frontend"
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 8080
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "alb_security_group_id" {
  description = "ALB Security Group ID"
  type        = string
}

variable "sg_egress_from_port" {
  description = "Egress from port"
  type        = number
  default     = 0
}

variable "sg_egress_to_port" {
  description = "Egress to port"
  type        = number
  default     = 0
}

variable "sg_egress_protocol" {
  description = "Egress protocol"
  type        = string
  default     = "-1"
}

variable "sg_egress_cidr_blocks" {
  description = "CIDR blocks for egress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = "ecs-service"
}

variable "ecs_desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 1
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the ECS task"
  type        = bool
  default     = false
}

variable "alb_target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "container_image" {
  type    = string
  default = ""
}

locals {
  final_image = var.container_image != "" ? var.container_image : env("CONTAINER_IMAGE")
}
