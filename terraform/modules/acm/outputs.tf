output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.tm-acm.arn
}

output "domain_validation_options" {
  value = aws_acm_certificate.tm-acm.domain_validation_options
  description = "The domain validation options for DNS validation"
}

