variable "name_prefix" {
  description = "Prefix to name resources"
  type        = string
}

variable "domain_name" {
  description = "Domain name to request ACM certificate for"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare DNS zone ID to create validation records"
  type        = string
}
