variable "name_prefix" {
  description = "Prefix for naming AWS resources"
  type        = string
}

variable "network_mode" {
  description = "ECS task network mode"
  type        = string
  default     = "awsvpc"
}

variable "requires_compatibilities" {
  description = "ECS task requires_compatibilities"
  type        = list(string)
  default     = ["FARGATE"]
}

variable "cpu" {
  description = "CPU units for ECS task"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Memory for ECS task (MiB)"
  type        = string
  default     = "512"
}

variable "execution_role_arn" {
  description = "ARN of the execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the task role"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_image" {
  description = "Container image URI"
  type        = string
}

variable "container_port" {
  description = "Container port to expose"
  type        = number
}

variable "container_port_protocol" {
  description = "Protocol for container port"
  type        = string
  default     = "tcp"
}

variable "desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 1
}

variable "launch_type" {
  description = "ECS launch type"
  type        = string
  default     = "FARGATE"
}

variable "platform_version" {
  description = "ECS platform version"
  type        = string
  default     = "LATEST"
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS tasks"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for ECS tasks"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "load_balancer_arn" {
  description = "ARN of the load balancer"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate"
  type        = string
}

variable "https_listener_port" {
  description = "Port for HTTPS listener"
  type        = number
  default     = 443
}

variable "https_listener_protocol" {
  description = "Protocol for HTTPS listener"
  type        = string
  default     = "HTTPS"
}

variable "default_action_type" {
  description = "Default action type for load balancer listener"
  type        = string
  default     = "forward"
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP"
  type        = bool
  default     = true
}
