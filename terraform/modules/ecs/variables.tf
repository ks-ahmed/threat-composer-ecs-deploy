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

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "image_url" {
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
  description = "Assign public IP to ECS task"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "VPC ID for the ECS service and security group"
  type        = string
}

variable "sg_description" {
  description = "Description for the ECS security group"
  type        = string
  default     = "Allow HTTP and HTTPS inbound"
}


variable "ingress_rules" {
  description = "List of ingress rules for the ECS security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "Allow HTTP from VPC CIDR"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    },
    {
      description = "Allow HTTPS from VPC CIDR"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    }
  ]
}

variable "egress_rules" {
  description = "List of egress rules for the ECS security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "alb_ingress_protocol" {
  description = "Protocol for ALB ingress traffic"
  type        = string
  default     = "tcp"
}

variable "alb_ingress_description" {
  description = "Description for ALB ingress rule"
  type        = string
  default     = "Allow traffic from ALB"
}


variable "execution_role_arn" {
  description = "ARN of the ECS execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group ID of the ALB"
  type        = string
}

variable "enable_container_insights" {
  description = "Enable CloudWatch Container Insights for ECS Cluster"
  type        = bool
  default     = true
}

variable "container_insights_name" {
  description = "Name of the ECS cluster setting"
  type        = string
  default     = "containerInsights"
}

variable "container_insights_value" {
  description = "Value for the ECS cluster setting"
  type        = string
  default     = "enabled"
}

