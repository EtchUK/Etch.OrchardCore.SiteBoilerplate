resource "aws_s3_bucket" "application" {
  bucket = var.project

  tags = {
    Name = var.project
  }
}

resource "aws_s3_bucket_acl" "application_bucket_acl" {
  bucket = aws_s3_bucket.application.id
  acl    = "private"
}