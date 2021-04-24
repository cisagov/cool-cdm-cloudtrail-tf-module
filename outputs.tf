output "access_role" {
  value       = aws_iam_role.cloudtrail
  description = "The IAM role that can be assumed to access the CDM CloudTrail data."
}

output "cloudtrail_access_policy" {
  value       = aws_iam_policy.cloudtrail
  description = "The IAM policy with the necessary permissions to access the CDM CloudTrail data."
}

output "cloudtrail_bucket" {
  value       = aws_s3_bucket.cloudtrail
  description = "The S3 bucket where CloudTrail logs are stored for CDM."
}

output "cloudtrail_deadletter_queue" {
  value       = aws_sqs_queue.cloudtrail_dlq
  description = "The SQS deadletter queue of messages notifying of CloudTrail logs being written to the CDM S3 bucket for which processing has failed."
}

output "cloudtrail_queue" {
  value       = aws_sqs_queue.cloudtrail
  description = "The SQS queue of messages notifying of CloudTrail logs being written to the CDM S3 bucket."
}

output "cloudtrail_topic" {
  value       = aws_sns_topic.cloudtrail
  description = "The SNS topic for notifications of CloudTrail logs being written to the CDM S3 bucket."
}

output "cloudtrail_trail" {
  value       = aws_cloudtrail.trail
  description = "The CloudTrail trail for CDM."
}
