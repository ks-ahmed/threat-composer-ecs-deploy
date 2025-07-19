variable "name_prefix" {
  description = "Prefix to name resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to deploy ALB into"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "target_port" {
  description = "Port to forward traffic to in ECS"
  type        = number
}

