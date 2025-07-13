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

variable "dynamo_billing_mode" {
    type = string
    default = "PAY_PER_REQUEST"
    description = "dynamo table billing mode"
}

variable "dynamo_hash_key" {
    type = string
    default  = "LockID"
    description = "dynamo table hash key"
}

locals {
  lifecycle_prevent_destroy = true
  versioning_configuration = "Enabled"
  sse_algorithm = "AES256"
  attribute_name = "LockID"
  attribute_type = "S"

}
