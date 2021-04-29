variable "accountname_role_arn" {
  type        = string
  description = "The ARN of the role to assume for the AccountName provider."
  default     = "arn:aws:iam::210987654321:role/ProvisionAccount"
}

variable "users_role_arn" {
  type        = string
  description = "The ARN of the role to assume for the default provider."
  default     = "arn:aws:iam::123456789012:role/ProvisionAccount"
}
