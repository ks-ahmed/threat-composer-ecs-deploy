terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}


resource "cloudflare_record" "dns_records" {
  for_each = {
    for record in var.records :
    "${record.name}-${record.type}" => record
  }

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  content   = each.value.content
  ttl     = each.value.ttl
  proxied = each.value.proxied
}
