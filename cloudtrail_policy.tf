# ------------------------------------------------------------------------------
# Provision the IAM policy that allows access the CDM CloudTrail data.
# ------------------------------------------------------------------------------

# Policy document that assigns the necessary permissions to access the
# CDM CloudTrail data.
data "aws_iam_policy_document" "allow_access_to_queue_and_bucket" {
  # SQS queue permissions
  statement {
    actions = [
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ListQueues",
      "sqs:ReceiveMessage",
    ]
    effect = "Allow"
    resources = [
      aws_sqs_queue.cloudtrail.arn,
    ]
  }

  # S3 bucket permissions
  statement {
    actions = [
      "s3:Get*",
      "s3:List*",
    ]
    effect = "Allow"
    resources = [
      aws_s3_bucket.cloudtrail_bucket.arn,
    ]
  }
  statement {
    actions = [
      "s3:Delete*",
      "s3:Get*",
      "s3:List*",
    ]
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.cloudtrail_bucket.arn}/*",
    ]
  }
}

# Policy with the necessary permissions to access the CDM CloudTrail
# data.
resource "aws_iam_policy" "cloudtrail" {
  description = var.cloudtrail_role_description
  name        = var.cloudtrail_role_name
  policy      = data.aws_iam_policy_document.allow_access_to_queue_and_bucket.json
  tags        = var.tags
}
