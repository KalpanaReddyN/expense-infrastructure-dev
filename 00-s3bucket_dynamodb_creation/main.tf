resource "aws_s3_bucket" "statefiles_bucket" {
  bucket = "dev-infra-statefile"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# resource "aws_s3_bucket_policy" "dev_statefile_policy" {
#   bucket = aws_s3_bucket.statefiles_bucket.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid       = "AllowAccountAccess"
#         Effect    = "Allow"
#         Principal = {
#           AWS = "arn:aws:iam::211125410910:root"  # Replace with your AWS Account ID
#         }
#         Action = [
#           "s3:GetObject",
#           "s3:PutObject",
#           "s3:DeleteObject",
#           "s3:ListBucket",
#           "s3:GetObjectTagging",
#           "s3:PutObjectTagging"
#         ]
#         Resource = [
#           "arn:aws:s3:::dev_infra_statefile",
#           "arn:aws:s3:::dev_infra_statefile/*"
#         ]
#       }
#     ]
#   })
# }

# resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
#   bucket = aws_s3_bucket.example.id
#   policy = data.aws_iam_policy_document.allow_access_from_another_account.json
# }

# data "aws_iam_policy_document" "allow_access_from_another_account" {
#   statement {
#     principals {
#       type        = "AWS"
#       identifiers = ["123456789012"]
#     }

#     actions = [
#       "s3:GetObject",
#       "s3:ListBucket",
#     ]

#     resources = [
#       aws_s3_bucket.example.arn,
#       "${aws_s3_bucket.example.arn}/*",
#     ]
#   }
# }