

variable "zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "domain" {
  description = "The domain name (e.g. app.example.com)"
  type        = string
}

variable "alb_dns" {
  description = "DNS name of the ALB to point the CNAME to"
  type        = string
}

variable "dns_record_type" {
  description = "DNS record type for app record"
  type        = string
  default     = "CNAME"
}

variable "dns_ttl" {
  description = "TTL for the app record"
  type        = number
  default     = 1
}

variable "dns_proxied" {
  description = "Whether the DNS record is proxied through Cloudflare"
  type        = bool
  default     = true
}

variable "validation_records" {
  description = "ACM DNS validation records"
  type = map(object({
    name  = string
    type  = string
    value = string
  }))
}

variable "validation_ttl" {
  description = "TTL for ACM validation records"
  type        = number
  default     = 60
}
