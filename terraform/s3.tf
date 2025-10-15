variable "bucket_name" {
  default = "4social.dev"
}

# Create S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}
