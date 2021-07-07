# ------------------------------------------------------------------------------
# Provision the S3 bucket where the CloudTrail logs for this account
# will be stored.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "cloudtrail" {
  # We can't perform this action until our policy is in place.
  depends_on = [
    aws_iam_role_policy_attachment.provisioncdmcloudtrail_policy_attachment,
  ]

  bucket_prefix = var.bucket_prefix
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# This blocks ANY public access to the bucket or the objects it
# contains, even if misconfigured to allow public access.
resource "aws_s3_bucket_public_access_block" "cloudtrail" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket.cloudtrail.id
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Policy document that allows CloudTrail to write logs to this bucket.
# See
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-s3-bucket-policy-for-cloudtrail.html.
data "aws_iam_policy_document" "allow_cloudtrail_to_write_logs" {
  # Allow ACL check
  statement {
    actions = [
      "s3:GetBucketAcl",
    ]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = [
      aws_s3_bucket.cloudtrail.arn,
    ]
  }

  # Allow writing of logs
  statement {
    actions = [
      "s3:PutObject",
    ]
    condition {
      values = [
        "bucket-owner-full-control",
      ]
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
    }
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = [
      "${aws_s3_bucket.cloudtrail.arn}/AWSLogs/${local.account_id}/*",
    ]
  }
}

# Policy that allows CloudTrail to write logs to this bucket
resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id
  policy = data.aws_iam_policy_document.allow_cloudtrail_to_write_logs.json
}
