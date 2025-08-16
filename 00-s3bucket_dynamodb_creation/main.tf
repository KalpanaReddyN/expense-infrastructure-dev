resource "aws_s3_bucket" "statefiles_bucket" {
  bucket = "dev-infra-statefile"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# this block of code is giving certain access to entire account
resource "aws_s3_bucket_policy" "dev_statefile_policy" {
  bucket = aws_s3_bucket.statefiles_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowAccountAccess"
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::211125410910:root"  # Replace with your AWS Account ID
        }
        Action = "s3:*"
        # Action = [
        #   "s3:GetObject",
        #   "s3:PutObject",
        #   "s3:DeleteObject",
        #   "s3:ListBucket",
        #   "s3:GetObjectTagging",
        #   "s3:PutObjectTagging"
        # ]
        Resource = [
          "arn:aws:s3:::dev-infra-statefile",
          "arn:aws:s3:::dev-infra-statefile/*"
        ]
      }
    ]
  })
}

# this block of code is giving certain access to certain users/roles
# resource "aws_s3_bucket_policy" "dev_statefile_policy" {
#   bucket = aws_s3_bucket.statefiles_bucket.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [

#       # Full access for sunil
#       {
#         Sid       = "FullAccessForSunil"
#         Effect    = "Allow"
#         Principal = {
#           AWS = "arn:aws:iam::211125410910:user/sunil"
#         }
#         Action = "s3:*"
#         Resource = [
#           "arn:aws:s3:::dev-infra-statefile",
#           "arn:aws:s3:::dev-infra-statefile/*"
#         ]
#       },

#       # Read-only for devops_user1
#       {
#         Sid       = "ReadOnlyForDevOpsUser1"
#         Effect    = "Allow"
#         Principal = {
#           AWS = "arn:aws:iam::211125410910:user/devops_user1"
#         }
#         Action = "s3:GetObject"
#         Resource = "arn:aws:s3:::dev-infra-statefile/*"
#       },

#       # Read + List for infra_admin
#       {
#         Sid       = "ReadListForInfraAdmin"
#         Effect    = "Allow"
#         Principal = {
#           AWS = "arn:aws:iam::211125410910:user/infra_admin"
#         }
#         Action = [
#           "s3:GetObject",
#           "s3:ListBucket"
#         ]
#         Resource = [
#           "arn:aws:s3:::dev-infra-statefile",
#           "arn:aws:s3:::dev-infra-statefile/*"
#         ]
#       },

#       # Read + Write for junior-devops role
#       {
#         Sid       = "ReadWriteForCIUser"
#         Effect    = "Allow"
#         Principal = {
#           AWS = "arn:aws:iam::211125410910:role/junior-devops"
#         }
#         Action = [
#           "s3:GetObject",
#           "s3:PutObject"
#         ]
#         Resource = "arn:aws:s3:::dev-infra-statefile/*"
#       }

#     ]
#   })
# }

resource "aws_s3_bucket_public_access_block" "statefiles_block_public" {
  bucket                  = aws_s3_bucket.statefiles_bucket.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# this code giving the access of bucket like get/list to the another aws account-123456789012
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

resource "aws_s3_bucket_versioning" "statefiles_versioning" {
  bucket = aws_s3_bucket.statefiles_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "key_for_statefile" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 7  # after 7 days key will be deleted so inorder to maintain the key use below
  # enable_key_rotation     = true
}

resource "aws_kms_alias" "a" {
  name          = "alias/key_for_statefile-alias"
  target_key_id = aws_kms_key.key_for_statefile.key_id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "statefiles_encryption" {
  bucket = aws_s3_bucket.statefiles_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_alias.a.arn
      
    }
  }
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "dev-infra-statefile-logs"

  tags = {
    Name        = "My-bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_logging" "logbucket" {
  bucket = aws_s3_bucket.statefiles_bucket.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}