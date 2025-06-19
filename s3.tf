provider "aws" {
  region = "us-east-1"  # change to your preferred region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-123456"  # must be globally unique
  acl    = "private"

  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
    Purpose     =  " testing    "
  }
}
