variable "aws_region" {
  description = "AWS region for ECS, ALB and Backend"
  type        = string
  default     = "eu-west-2"
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}


variable "domain" {
  description = "Domain name (e.g., app.example.com)"
  type        = string
}

variable "name_prefix" {
  description = "Name prefix for all resources"
  type        = string
  default     = "myapp"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "container_name" {
  description = "ECS container name"
  type        = string
  default     = "react-app"
}

variable "container_image" {
  description = "Container image URL (ECR or Docker Hub)"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
  default     = 80
}

variable "desired_count" {
  description = "Number of ECS tasks"
  type        = number
  default     = 1
}


variable "backend_bucket_name" {
  type        = string
  description = "Name of the S3 bucket for Terraform state"
}

variable "backend_dynamodb_table_name" {
  type        = string
  description = "Name of the DynamoDB table for state locking"
}

variable "default_tags" {
  type = map(string)
  default = {
    Environment = "infrastructure"
    ManagedBy   = "Terraform"
  }
}

variable "validation_method" {
  type = string
}

variable "cloudflare_ttl" {
  type = number
}
