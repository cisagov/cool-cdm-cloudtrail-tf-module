# ------------------------------------------------------------------------------
# Provision the CloudTrail trail that will feed logs to the CDM
# CloudTrail bucket and notify via the SNS topic when it does so.
# ------------------------------------------------------------------------------

resource "aws_cloudtrail" "trail" {
  enable_log_file_validation = true
  is_multi_region_trail      = true
  name                       = var.trail_name
  s3_bucket_name             = aws_s3_bucket.cloudtrail.id
  sns_topic_name             = aws_sns_topic.cloudtrail.name
  tags                       = var.tags
}
