variable "domain" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "load_balancer_arn" {
  description = "ARN of the load balancer"
  type        = string
}
