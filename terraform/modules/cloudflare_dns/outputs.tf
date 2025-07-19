output "dns_records" {
  description = "Map of created Cloudflare DNS records"
  value = {
    for key, rec in cloudflare_record.dns_records :
    key => {
      id      = rec.id
      name    = rec.name
      type    = rec.type
      content = rec.content
      ttl     = rec.ttl
      proxied = rec.proxied
    }
  }
}
