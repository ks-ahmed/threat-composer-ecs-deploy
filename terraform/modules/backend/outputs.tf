output "bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "The name of the S3 bucket for Terraform state."
}

output "object_lock_enabled" {
  value = aws_s3_bucket.terraform_state.object_lock_enabled
}
