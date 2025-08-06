# S3 Bucket for Terraform State
resource "aws_s3_bucket" "tfstate" {
  bucket        = "${var.prefix}-tfstate"
  force_destroy = true

  tags = {
    Name        = "${var.prefix}-tfstate"
    Environment = "backend"
    Purpose     = "terraform-state"
  }
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_encryption" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "tfstate_pab" {
  bucket = aws_s3_bucket.tfstate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
