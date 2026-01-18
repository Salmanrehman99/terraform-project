terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "avatars" {
  bucket = "grocerymate-avatars-unique-16623"  # Replace with a unique name

  tags = {
    Name        = "grocerymate-avatars"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "avatars_acl" {
  bucket = aws_s3_bucket.avatars.bucket
  acl    = "private"  # Use acl here in a separate resource
}

resource "aws_s3_bucket_versioning" "avatars_versioning" {
  bucket = aws_s3_bucket.avatars.id

  versioning_configuration {
    status = "Enabled"
  }
}

