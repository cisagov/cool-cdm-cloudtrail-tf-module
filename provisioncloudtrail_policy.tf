# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient permissions to
# provision the CloudTrail-related resources for CDM access.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisioncloudtrail_doc" {
  # Permissions necessary to manipulate the S3 bucket where CloudTrail
  # logs are stored.
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_prefix}*",
    ]
  }
}

# The IAM policy
resource "aws_iam_policy" "provisioncloudtrail_policy" {
  description = var.provisioncloudtrail_policy_description
  name        = var.provisioncloudtrail_policy_name
  policy      = data.aws_iam_policy_document.provisioncloudtrail_doc.json
}
