variable "bucket_name" {
  description = "The name of the S3 bucket used for storing Terraform state"
  type        = string
}

variable "versioning_status" {
  description = "Versioning status for the S3 bucket (e.g., Enabled or Suspended)"
  type        = string
  default     = "Enabled"
}

variable "tags" {
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default = {
    Name = "Terraform State Bucket"
  }
}
