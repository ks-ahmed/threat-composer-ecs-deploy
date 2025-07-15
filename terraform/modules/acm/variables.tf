variable "domain" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}

variable "name_prefix" {
  type = string
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
