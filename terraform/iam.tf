
# Create IAM role for S3 access
resource "aws_iam_role" "s3_full_access_role" {
  name = "s3-app-storage-full-access-role"

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
resource "aws_iam_policy" "s3_full_access_policy" {
  name = "s3-app-storage-full-access-policy"

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
            # "${aws_s3_bucket.app_storage.arn}/*"
        ]
      }
    ]
  })
}

# # Attach policy to role
resource "aws_iam_role_policy_attachment" "s3_full_access_attachment" {
  role       = aws_iam_role.s3_full_access_role.name
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
}
