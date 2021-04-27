output "access_policy" {
  value       = module.example.access_policy
  description = "The IAM policy with the necessary permissions to access the CDM CloudTrail data."
}

output "access_role" {
  value       = module.example.access_role
  description = "The IAM role that can be assumed to access the CDM CloudTrail data."
}

output "assume_access_role_policy" {
  value       = module.example.assume_access_role_policy
  description = "The IAM policy that allows the CDM user to assume the IAM role that allows access the CDM CloudTrail data."
}

output "bucket" {
  value       = module.example.bucket
  description = "The S3 bucket where CloudTrail logs are stored for CDM."
}

output "deadletter_queue" {
  value       = module.example.deadletter_queue
  description = "The SQS deadletter queue of messages notifying of CloudTrail logs being written to the CDM S3 bucket for which processing has failed."
}

output "queue" {
  value       = module.example.queue
  description = "The SQS queue of messages notifying of CloudTrail logs being written to the CDM S3 bucket."
}

output "topic" {
  value       = module.example.topic
  description = "The SNS topic for notifications of CloudTrail logs being written to the CDM S3 bucket."
}

output "trail" {
  value       = module.example.trail
  description = "The CloudTrail trail for CDM."
}
