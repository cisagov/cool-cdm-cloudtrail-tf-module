# ------------------------------------------------------------------------------
# Provision the S3 bucket where the CloudTrail logs for this account
# will be stored.
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "cloudtrail" {
  # We can't perform this action until our policy is in place.
  depends_on = [
    aws_iam_role_policy_attachment.provisioncloudtrail_policy_attachment,
  ]

  bucket_prefix = var.cloudtrail_bucket_prefix
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = var.tags
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
