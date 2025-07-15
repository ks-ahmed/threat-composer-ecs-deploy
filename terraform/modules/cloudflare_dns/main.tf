terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}


resource "cloudflare_record" "app" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name
  content   = var.target
  type    = var.cloudflare_record_type
  ttl     = var.cloudflare_record_ttl
  proxied = var.cloudflare_record_proxied
}
