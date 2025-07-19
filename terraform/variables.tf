variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "aws_region" {
    type = string
    description = "AWS Region for my VPC"
  
}

variable "domain_name" {
  type        = string
  description = "Domain name for HTTPS"
}

variable "name_prefix" {
  type        = string
  description = "Prefix used for naming AWS resources"
}

variable "container_image" {
  type        = string
  description = "Docker image URI for ECS task"
}

variable "container_port" {
  type        = number
  description = "Port exposed by your ECS container"
}

variable "desired_count" {
  type        = number
  description = "Number of ECS tasks to run"
  default     = 2
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID for your domain"
  type        = string
}

variable "terra_bucket_name" {
  description = "S3 bucket name for Terraform backend state"
  type        = string
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token with DNS edit permissions"
  sensitive   = true
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}
