variable "zone_id" {
  type        = string
  description = "Cloudflare zone ID for the DNS records"
}

variable "records" {
  description = "List of Cloudflare DNS records to create"
  type = list(object({
    name    = string
    type    = string
    content = string
    ttl     = number
    proxied = bool
  }))
  validation {
    condition     = length(var.records) > 0
    error_message = "You must provide at least one DNS record."
  }
}
