variable "bucket_name" {
  description = "Name of the S3 bucket used for Terraform backend"
  type        = string
  default = "threat-composer-bucket"
}

variable "retention_days" {
  description = "Number of days for object lock retention"
  type        = number
  default     = 30
}