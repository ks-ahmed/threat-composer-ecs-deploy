variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "ecs-todo"
}

variable "region" {
  description = "AWS region to deploy"
  type        = string
  default     = "eu-west-2"
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}

variable "container_image" {
  description = "Full Docker image URI (ECR or other) for ECS task"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  description = "Availability zones to use"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "alb_certificate_arn" {
  description = "ARN of ACM certificate for HTTPS"
  type        = string
}

variable "alb_port" {
  description = "Port for the ALB listener"
  type        = number
  default     = 443
}
