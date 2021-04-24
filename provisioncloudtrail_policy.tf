# ------------------------------------------------------------------------------
# Create the IAM policy that allows sufficient permissions to
# provision the CloudTrail-related resources for CDM access.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisioncloudtrail_doc" {
  # Permissions necessary to manipulate the S3 bucket where CloudTrail
  # logs are stored.
  statement {
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_prefix}*",
    ]
  }

  # Permissions necessary to manipulate the CloudTrail trail that
  # generates the logs for CDM.
  statement {
    actions = [
      "cloudtrail:*",
    ]
    resources = [
      "arn:aws:cloudtrail:${var.aws_region}:${local.account_id}:trail/${var.trail_name}",
    ]
  }

  # Permissions necessary to manipulate the SQS queue that contains
  # messages indicating CloudTrail logs that have been added to the S3
  # bucket.
  statement {
    actions = [
      "sqs:*",
    ]
    resources = [
      "arn:aws:sqs:${var.aws_region}:${local.account_id}:${var.queue_name}",
    ]
  }

  # Permissions necessary to manipulate the SNS topic that publishes
  # notifications when CloudTrail logs that have been added to the S3
  # bucket.
  statement {
    actions = [
      "sns:*",
    ]
    resources = [
      "arn:aws:sns:${var.aws_region}:${local.account_id}:${var.topic_name}",
    ]
  }
}

# The IAM policy
resource "aws_iam_policy" "provisioncloudtrail_policy" {
  description = var.provisioncloudtrail_policy_description
  name        = var.provisioncloudtrail_policy_name
  policy      = data.aws_iam_policy_document.provisioncloudtrail_doc.json
}
