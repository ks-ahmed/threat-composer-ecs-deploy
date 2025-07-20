output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.this.arn
}

output "domain_validation_options" {
  description = "Domain validation options for ACM"
  value       = aws_acm_certificate.this.domain_validation_options
}

output "validation_record_names" {
  description = "Cloudflare DNS validation record names"
  value       = [for record in cloudflare_record.validation : record.name]
}
