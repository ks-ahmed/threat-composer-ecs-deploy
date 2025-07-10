variable "aws_region" {
  description = "AWS region for most resources"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "name_prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "ecs-todo"
}

variable "domain" {
  description = "Domain name for ACM certificate"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID for DNS validation"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API Token with DNS edit permissions"
  type        = string
  sensitive   = true
}

variable "image" {
  description = "Docker image URI for ECS service"
  type        = string
}

variable "desired_count" {
  description = "Number of ECS tasks"
  type        = number
  default     = 1
}

variable "container_port" {
  description = "Port exposed by container"
  type        = number
  default     = 80
}

variable "cpu" {
  description = "CPU units for ECS task"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Memory (MB) for ECS task"
  type        = string
  default     = "512"
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "ecs-todo"
  }
}
