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
# Enable Versioning
########################
resource "aws_s3_bucket_versioning" "avatars_bucket_versioning" {
  bucket = aws_s3_bucket.avatars_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
