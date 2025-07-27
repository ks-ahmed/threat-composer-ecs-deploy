output "bucket_name" {
  description = "The name of the Terraform state S3 bucket"
  value       = aws_s3_bucket.tf_state.id
}
