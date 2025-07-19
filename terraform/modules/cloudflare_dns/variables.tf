variable "zone_id" {
  type = string
}

variable "records" {
  type = list(object({
    name    = string
    type    = string
    content = string
    ttl     = number
    proxied = bool
  }))
}
