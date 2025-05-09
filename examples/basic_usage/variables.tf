# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "accountname_role_arn" {
  default     = "arn:aws:iam::210987654321:role/ProvisionAccount"
  description = "The ARN of the role to assume for the AccountName provider."
  nullable    = false
  type        = string
}

variable "users_role_arn" {
  default     = "arn:aws:iam::123456789012:role/ProvisionAccount"
  description = "The ARN of the role to assume for the default provider."
  nullable    = false
  type        = string
}
