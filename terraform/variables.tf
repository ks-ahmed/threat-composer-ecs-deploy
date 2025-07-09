variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
}


variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "domain" {
  description = "Domain name for ACM certificate (e.g., tm.labs.example.com)"
  type        = string
}

variable "zone_id" {
  description = "Route53 Hosted Zone ID for the domain"
  type        = string
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "todo-cluster"
}

variable "task_family" {
  description = "ECS Task family name"
  type        = string
  default     = "todo-task"
}

variable "image_url" {
  description = "Docker image URL for ECS task"
  type        = string
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}
