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

variable "validation_method" {
  description = "The validation method for the ACM certificate."
  type        = string
  default     = "DNS"
}

variable "cloudflare_ttl" {
  description = "TTL for the cloudflare DNS records"
  type = number
  default = 120

}

locals {
  aws_source = "hashicorp/aws"
  cloudflare_source = "cloudflare/cloudflare"
}