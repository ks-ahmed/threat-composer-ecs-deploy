variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "internal" {
  description = "Whether the ALB is internal"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "The type of load balancer"
  type        = string
  default     = "application"
}


variable "subnet_ids" {
  description = "Subnets for the ALB"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Whether to enable deletion protection on the ALB"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "The VPC ID to attach the ALB security group"
  type        = string
}


variable "target_port" {
  description = "Port for target group"
  type        = number
}

variable "target_protocol" {
  description = "Protocol for target group"
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  description = "Target type for the group"
  type        = string
  default     = "ip"
}

variable "health_check_path" {
  description = "Path for health check"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "Interval for health checks (in seconds)"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout for health checks (in seconds)"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Number of successful checks before considering healthy"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "Number of failed checks before considering unhealthy"
  type        = number
  default     = 3
}

variable "health_check_matcher" {
  description = "HTTP code matcher for health check"
  type        = string
  default     = "200-399"
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate"
  type        = string
}

variable "https_listener_port" {
  type        = number
  default     = 443
}

variable "https_listener_protocol" {
  type        = string
  default     = "HTTPS"
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

variable "ssl_policy" {
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
  description = "SSL policy for HTTPS listener"
}

locals {
  default_action_https = "forward"
  default_action_http = "redirect"
}

variable "tags" {
  description = "Tags to apply to ALB resources"
  type        = map(string)
  default     = {}
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  type        = bool
  default     = true
}

variable "access_logs_bucket" {
  description = "S3 bucket name to store ALB access logs"
  type        = string
  default     = ""  
}

variable "access_logs_prefix" {
  description = "Prefix for ALB access logs in the bucket"
  type        = string
  default     = "alb-logs/"
}

variable "security_group_description" {
  description = "Description for the security group"
  type        = string
  default     = "Allow HTTP and HTTPS inbound traffic"
}

variable "http_ingress_cidr_blocks" {
  description = "List of CIDR blocks allowed to access HTTP (port 80)"
  type        = list(string)
  default     = ["203.0.113.0/24"]
}

variable "https_ingress_cidr_blocks" {
  description = "List of CIDR blocks allowed to access HTTPS (port 443)"
  type        = list(string)
  default     = ["203.0.113.0/24"]
}

variable "http_ingress_description" {
  description = "Description for HTTP ingress rule"
  type        = string
  default     = "Allow HTTP from trusted CIDR"
}

variable "https_ingress_description" {
  description = "Description for HTTPS ingress rule"
  type        = string
  default     = "Allow HTTPS from trusted CIDR"
}

variable "egress_cidr_blocks" {
  description = "CIDR blocks allowed for outbound traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_description" {
  description = "Description for egress rule"
  type        = string
  default     = "Allow all outbound traffic"
}
