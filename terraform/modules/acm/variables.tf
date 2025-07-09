variable "domain" {
  description = "Domain name for the ACM certificate (e.g., tm.labs.example.com)"
  type        = string
}

variable "zone_id" {
  description = "Route53 Hosted Zone ID for the domain"
  type        = string
}
