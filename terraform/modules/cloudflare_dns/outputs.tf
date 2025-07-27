output "record_fqdn" {
  value = cloudflare_record.app.hostname
}

output "validation_fqdns" {
  value = [
    for record in cloudflare_record.validation : record.name
  ]
}

