terraform {
  required_providers {
    aws = {
      source = local.aws_source
    }
    cloudflare = {
      source = local.cloudflare_source
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
