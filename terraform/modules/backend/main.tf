resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = local.lifecycle_prevent_destroy
  }

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = local.versioning_configuration
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = local.sse_algorithm
    }
  }
}


resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = var.dynamo_billing_mode
  hash_key     = var.dynamo_hash_key

  attribute {
    name = local.attribute_name
    type = local.attribute_type
  }

  lifecycle {
    prevent_destroy = local.lifecycle_prevent_destroy
  }


  tags = var.tags
}
