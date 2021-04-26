# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------
variable "aws_region" {
  type        = string
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "bucket_prefix" {
  type        = string
  description = "A prefix to use when creating a unique name for the S3 bucket where CloudTrail logs will be collected for CDM.  Terraform will create a unique bucket name beginning with the specified prefix."
  default     = "cdm-cloudtrail-"
}

variable "cdm_user_name" {
  type        = string
  description = "The user name of the CDM user who will assume the role to access the CloudTrail data."
  default     = "cdm-splunk-access"
}

variable "deadletter_queue_name" {
  type        = string
  description = "The name of the deadletter queue associated with the SQS queue that collects the messages sent when CloudTrail logs are written to the CDM CloudTrail bucket."
  default     = "cdm-cloudtrail-deadletter"
}

variable "provisionaccount_role_name" {
  type        = string
  description = "The name of the IAM role that allows sufficient permissions to provision all AWS resources in the account."
  default     = "ProvisionAccount"
}

variable "provisioncdmcloudtrail_policy_description" {
  type        = string
  description = "The description of the IAM policy that allows sufficient permissions to provision all CDM CloudTrail AWS resources in the account."
  default     = "Allows provisioning of the CDM CloudTrail resources in the account."
}

variable "provisioncdmcloudtrail_policy_name" {
  type        = string
  description = "The name of the IAM policy that allows sufficient permissions to provision all CDM CloudTrail AWS resources in the account."
  default     = "ProvisionCdmCloudTrail"
}

variable "role_description" {
  type        = string
  description = "The description to assign the IAM role (as well as the corresponding policy) that allows access to the CDM Cloudtrail data."
  default     = "Allows access to the CDM Cloudtrail data."
}

variable "role_name" {
  type        = string
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows access to the CDM Cloudtrail data."
  default     = "cdm-cloudtrail"
}

variable "queue_name" {
  type        = string
  description = "The name of the SQS queue that collects the messages sent when CloudTrail logs are written to the CDM CloudTrail bucket."
  default     = "cdm-cloudtrail"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}

variable "topic_name" {
  type        = string
  description = "The name of the SNS topic that sends a message when CloudTrail logs are written to the CDM CloudTrail bucket."
  default     = "cdm-cloudtrail"
}

variable "trail_name" {
  type        = string
  description = "The name of the CloudTrail trail that generates the information for import into CDM."
  default     = "cdm-cloudtrail"
}
