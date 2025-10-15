
# Create IAM role for S3 access
resource "aws_iam_role" "my_bucket_full_access_role" {
  name = "s3-${var.bucket_name}-full-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# # Create IAM policy for full S3 bucket access
resource "aws_iam_policy" "my_bucket_access_policy" {
  name = "s3-${var.bucket_name}-full-access-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
            aws_s3_bucket.my_bucket.arn
        ]
      }
    ]
  })
}

# # Attach policy to role
resource "aws_iam_role_policy_attachment" "my_bucketfull_access_attachment" {
  role       = aws_iam_role.my_bucket_full_access_role.name
  policy_arn = aws_iam_policy.my_bucket_access_policy.arn
}
