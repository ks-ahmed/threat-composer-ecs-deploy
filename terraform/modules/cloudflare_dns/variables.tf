variable "cloudflare_zone_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "target" {
  type = string
}

locals {
  aws_source = "hashicorp/aws"
  cloudflare_source = "cloudflare/cloudflare"
}

variable "cloudflare_record_type" {
  type = string
  default = "CNAME"
  description = "Cloudflare record type for the app"
}

variable "cloudflare_record_ttl" {
  type = number
  default = 1
  description = "Cloudflare record ttl for the app"
}

variable "cloudflare_record_proxied" {
  type = bool
  default = true
  description = "Cloudflare record proxied for the app"
}