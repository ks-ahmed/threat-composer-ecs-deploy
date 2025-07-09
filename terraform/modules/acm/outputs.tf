output "cert_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.cert.arn
}

output "cert_domain" {
  description = "Domain name for the ACM certificate"
  value       = aws_acm_certificate.cert.domain_name
}
