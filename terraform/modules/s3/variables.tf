variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket for Terraform state"
}

variable "retention_days" {
  type        = number
  default     = 30
  description = "Number of days to retain locked objects in S3"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the S3 bucket"
}
