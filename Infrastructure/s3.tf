########################
# S3 Bucket
########################
resource "aws_s3_bucket" "avatars_bucket" {
  bucket = "grocerymate-avatars-unique-16623"

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

########################
# IAM Policy (S3 Full Access – Bucket Scoped)
########################
resource "aws_iam_policy" "avatars_s3_policy" {
  name        = "grocerymate-avatars-s3-full-access"
  description = "Full access to grocerymate avatars S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:*"]
        Resource = [
          aws_s3_bucket.avatars_bucket.arn,
          "${aws_s3_bucket.avatars_bucket.arn}/*"
        ]
      }
    ]
  })
}

########################
# IAM Role (for EC2 + SSM)
########################
resource "aws_iam_role" "avatars_role" {
  name = "grocerymate-avatars-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "ec2.amazonaws.com",
            "ssm.amazonaws.com"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

########################
# Attach Policy to Role
########################
resource "aws_iam_role_policy_attachment" "avatars_attach" {
  role       = aws_iam_role.avatars_role.name
  policy_arn = aws_iam_policy.avatars_s3_policy.arn
}

########################
# IAM Instance Profile (for EC2)
########################
resource "aws_iam_instance_profile" "avatars_profile" {
  name = "grocerymate-avatars-profile"
  role = aws_iam_role.avatars_role.name
}
