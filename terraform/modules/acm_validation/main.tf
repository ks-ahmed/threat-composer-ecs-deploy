terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = var.certificate_arn
  validation_record_fqdns = var.validation_record_fqdns
}
