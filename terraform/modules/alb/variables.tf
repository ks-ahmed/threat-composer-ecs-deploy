variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate"
  type        = string
}

variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
  default     = "ecs-alb"
}

variable "lb_internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "lb_type" {
  description = "Type of the load balancer"
  type        = string
  default     = "application"
}

variable "sg_name" {
  description = "Name of the ALB security group"
  type        = string
  default     = "alb-sg"
}

variable "sg_ingress_cidr_blocks" {
  description = "CIDR blocks allowed to access the ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "http_port" {
  description = "Port for HTTP listener"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "Port for HTTPS listener"
  type        = number
  default     = 443
}

variable "ssl_policy" {
  description = "SSL policy for HTTPS listener"
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
  default     = "ecs-targets"
}

variable "target_group_port" {
  description = "Port on which the targets receive traffic"
  type        = number
  default     = 8080
}

variable "target_group_protocol" {
  description = "Protocol for target group"
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  description = "Target type (ip or instance)"
  type        = string
  default     = "ip"
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}

variable "health_check_protocol" {
  description = "Protocol for health checks"
  type        = string
  default     = "HTTP"
}

variable "health_check_matcher" {
  description = "Status code matcher for health checks"
  type        = string
  default     = "200"
}

variable "health_check_interval" {
  description = "Interval between health checks (in seconds)"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout for health checks (in seconds)"
  type        = number
  default     = 5
}

variable "health_check_healthy_threshold" {
  description = "Number of successful checks before target is healthy"
  type        = number
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "Number of failed checks before target is unhealthy"
  type        = number
  default     = 2
}

variable "sg_egress_cidr_blocks" {
  description = "CIDR blocks allowed for egress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "sg_egress_protocol" {
  description = "Protocol for egress traffic"
  type        = string
  default     = "-1"
}

variable "sg_egress_from_port" {
  description = "Egress from port"
  type        = number
  default     = 0
}

variable "sg_egress_to_port" {
  description = "Egress to port"
  type        = number
  default     = 0
}
