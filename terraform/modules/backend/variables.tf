variable "bucket_name" {
  type        = string
  description = "S3 bucket name for storing Terraform state"
}

variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name for state locking"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to resources"
}
