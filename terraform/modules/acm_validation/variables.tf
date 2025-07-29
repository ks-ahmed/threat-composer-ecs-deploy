variable "certificate_arn" {
  description = "ACM Certificate ARN"
  type        = string
}

variable "validation_record_fqdns" {
  description = "List of validation FQDNs"
  type        = list(string)
}
