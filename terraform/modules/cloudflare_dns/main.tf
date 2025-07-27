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
  zone_id = var.zone_id
  name    = var.domain
  type    = var.dns_record_type
  content = var.alb_dns
  ttl     = var.dns_ttl
  proxied = var.dns_proxied
}

resource "cloudflare_record" "validation" {
  for_each = var.validation_records

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  content = each.value.value
  ttl     = var.validation_ttl
}
