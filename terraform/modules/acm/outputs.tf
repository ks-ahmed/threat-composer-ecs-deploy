output "certificate_arn" {
  value       = aws_acm_certificate.cert.arn
  description = "ARN of the validated ACM certificate"
}
