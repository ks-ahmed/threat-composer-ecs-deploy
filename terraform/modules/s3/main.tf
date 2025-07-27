resource "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "Terraform State Bucket"
  }
}
