# ------------------------------------------------------------------------------
# Provision the CloudTrail SQS queue that will collect notifications
# of logs being written to the CDM CloudTrail.
# ------------------------------------------------------------------------------

# CDM queue of messages notifying of CloudTrail logs being written to
# the CDM S3 bucket
resource "aws_sqs_queue" "cloudtrail" {
  # We can't perform this action until our policy is in place.
  depends_on = [
    aws_iam_role_policy_attachment.provisioncloudtrail_policy_attachment,
  ]

  name = var.queue_name
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.cloudtrail_dlq.arn
    # Move messages to the DLQ if the user can't process them after
    # five tries.
    maxReceiveCount = 4
  })
  tags = var.tags
}

# Policy document that allows the SNS topic to send messages to this
# queue
data "aws_iam_policy_document" "allow_cloudtrail_topic_to_send_messages" {
  statement {
    actions = [
      "sqs:SendMessage",
    ]
    effect = "Allow"
    condition {
      values = [
        aws_sns_topic.cloudtrail.arn,
      ]
      test     = "ArnEquals"
      variable = "aws:SourceArn"
    }
    resources = [
      aws_sqs_queue.cloudtrail.arn,
    ]
  }
}

# Policy that allows the SNS topic to send messages to this queue
resource "aws_sqs_queue_policy" "cloudtrail" {
  policy    = data.aws_iam_policy_document.allow_cloudtrail_topic_to_send_messages.json
  queue_url = aws_sqs_queue.cloudtrail.id
}

# CDM dead letter queue (messages sent to CDM queue that cannot be
# processed)
resource "aws_sqs_queue" "cloudtrail_dlq" {
  name = var.deadletter_queue_name
  tags = var.tags
}

# Subscription of the SQS queue to the SNS topic
resource "aws_sns_topic_subscription" "cloudtrail" {
  endpoint  = aws_sqs_queue.cloudtrail.arn
  protocol  = "sqs"
  topic_arn = aws_sns_topic.cloudtrail.arn
}
