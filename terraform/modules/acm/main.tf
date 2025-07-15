terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}


resource "aws_acm_certificate" "cert" {
  provider          = aws
  domain_name       = var.domain
  validation_method = var.validation_method

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.name_prefix}-acm-cert"
  }
}


resource "cloudflare_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = var.cloudflare_zone_id
  name    = each.value.name
  type    = each.value.type
  content   = each.value.value
  ttl     = var.cloudflare_ttl
}

resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in cloudflare_record.validation : record.hostname]
}
