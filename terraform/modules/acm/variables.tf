variable "domain" {
  type        = string
  description = "The domain name for the ACM certificate"
}

variable "validation_method" {
  type        = string
  default     = "DNS"
  description = "The validation method for the ACM certificate (DNS or EMAIL)"
}

variable "certificate_tags" {
  type        = map(string)
  default     = { Name = "ACM Certificate" }
  description = "Tags to apply to the ACM certificate"
}


