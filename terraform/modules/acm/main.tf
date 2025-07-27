resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain
  validation_method = var.validation_method

  lifecycle {
    create_before_destroy = true
  }

  tags = var.certificate_tags
}
