terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
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
