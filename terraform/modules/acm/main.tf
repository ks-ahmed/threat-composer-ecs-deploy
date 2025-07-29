terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain
  validation_method = var.validation_method

  lifecycle {
    create_before_destroy = true
  }

  tags = var.certificate_tags
}
