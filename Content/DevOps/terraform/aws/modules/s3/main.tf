resource "aws_s3_bucket" "application" {
  bucket = var.project

  tags = {
    Name = var.project
  }
}

resource "aws_s3_bucket_ownership_controls" "application" {
  bucket = aws_s3_bucket.application.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "application_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.application]

  bucket = aws_s3_bucket.application.id
  acl    = "private"
}