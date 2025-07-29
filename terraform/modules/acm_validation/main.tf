terraform {
  required_version = ">= 1.3.0"
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = var.certificate_arn
  validation_record_fqdns = var.validation_record_fqdns
}
