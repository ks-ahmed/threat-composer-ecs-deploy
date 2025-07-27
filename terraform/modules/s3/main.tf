resource "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = false
  }

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = var.versioning_status
  }
}
