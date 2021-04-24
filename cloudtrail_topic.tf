# ------------------------------------------------------------------------------
# Provision the SNS topic for notifications of logs being written to
# the CDM CloudTrail bucket.
# ------------------------------------------------------------------------------

resource "aws_sns_topic" "cloudtrail" {
  name = var.cloudtrail_topic_name
  tags = var.tags
}

# Policy document that allows CloudTrail to publish to this topic
data "aws_iam_policy_document" "allow_cloudtrail_to_publish_to_topic" {
  statement {
    actions = [
      "sns:Publish",
    ]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = [
      aws_sns_topic.cloudtrail.arn,
    ]
  }
}

# Policy that allows CloudTrail to publish to this topic
resource "aws_sns_topic_policy" "cloudtrail" {
  arn    = aws_sqs_queue.cloudtrail.arn
  policy = data.aws_iam_policy_document.allow_cloudtrail_to_publish_to_topic.json
}
