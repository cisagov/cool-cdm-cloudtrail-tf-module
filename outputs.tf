output "access_policy" {
  value       = aws_iam_policy.cloudtrail
  description = "The IAM policy with the necessary permissions to access the CDM CloudTrail data."
}

output "access_role" {
  value       = aws_iam_role.cloudtrail
  description = "The IAM role that can be assumed to access the CDM CloudTrail data."
}

output "assume_access_role_policy" {
  value       = aws_iam_policy.cdm
  description = "The IAM policy that allows the CDM user to assume the IAM role that allows access the CDM CloudTrail data."
}

output "bucket" {
  value       = aws_s3_bucket.cloudtrail
  description = "The S3 bucket where CloudTrail logs are stored for CDM."
}

output "deadletter_queue" {
  value       = aws_sqs_queue.cloudtrail_dlq
  description = "The SQS deadletter queue of messages notifying of CloudTrail logs being written to the CDM S3 bucket for which processing has failed."
}

output "queue" {
  value       = aws_sqs_queue.cloudtrail
  description = "The SQS queue of messages notifying of CloudTrail logs being written to the CDM S3 bucket."
}

output "topic" {
  value       = aws_sns_topic.cloudtrail
  description = "The SNS topic for notifications of CloudTrail logs being written to the CDM S3 bucket."
}

output "trail" {
  value       = aws_cloudtrail.trail
  description = "The CloudTrail trail for CDM."
}
