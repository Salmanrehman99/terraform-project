########################
# S3 Bucket
########################
resource "aws_s3_bucket" "avatars_bucket" {
  bucket = var.bucket_name  

  tags = {
    Name        = "grocerymate-avatars"  
    Environment = "Dev"
  }
}

########################
# Block All Public Access (KEEP BUCKET PRIVATE)
########################
resource "aws_s3_bucket_public_access_block" "avatars_bucket_block_public" {
  bucket = aws_s3_bucket.avatars_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

########################
# Enable Versioning
########################
resource "aws_s3_bucket_versioning" "avatars_bucket_versioning" {
  bucket = aws_s3_bucket.avatars_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
