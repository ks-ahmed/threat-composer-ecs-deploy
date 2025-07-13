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
  type        = string
}

variable "cloudflare_ttl" {
  type        = number
}

variable "cloudflare_record_type" {
  description = "Type of DNS record (e.g., A, CNAME)"
  type        = string
  default     = "CNAME"
}

variable "cloudflare_record_ttl" {
  description = "TTL for the DNS record"
  type        = number
  default     = 300
}

variable "cloudflare_record_proxied" {
  description = "Whether Cloudflare should proxy this record"
  type        = bool
  default     = true
}


variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "alb_internal" {
  type        = bool
  default     = false
  description = "Whether the ALB is internal or external"
}

variable "alb_type" {
  type        = string
  default     = "application"
  description = "Type of Load Balancer"
}

variable "alb_security_group_ids" {
  type        = list(string)
  description = "Security group IDs for the ALB"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "enable_alb_deletion_protection" {
  type        = bool
  default     = false
  description = "Enable deletion protection on the ALB"
}

variable "target_port" {
  type        = number
  default     = 80
}

variable "target_protocol" {
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  type        = string
}

variable "target_type" {
  type        = string
  default     = "ip"
}

variable "health_check_path" {
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  type        = number
  default     = 3
}

variable "health_check_matcher" {
  type        = string
  default     = "200-399"
}

variable "https_listener_port" {
  type        = number
  default     = 443
}

variable "https_listener_protocol" {
  type        = string
  default     = "HTTPS"
}

variable "ssl_policy" {
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "http_listener_port" {
  type        = number
  default     = 80
}

variable "http_listener_protocol" {
  type        = string
  default     = "HTTP"
}

variable "redirect_port" {
  type        = string
  default     = "443"
}

variable "redirect_protocol" {
  type        = string
  default     = "HTTPS"
}

variable "redirect_status_code" {
  type        = string
  default     = "HTTP_301"
}

variable "subnet_public_ip" {
  type = bool
  default = true
  description = "map public ip on launch"
  
}

variable "routing_cidr_block" {
  type = string
  default = "0.0.0.0/0"
  description = "Internet access cidr block"
  
}

variable "dynamo_billing_mode" {
    type = string
    default = "PAY_PER_REQUEST"
    description = "dynamo table billing mode"
}

variable "dynamo_hash_key" {
    type = string
    default  = "LockID"
    description = "dynamo table hash key"
}