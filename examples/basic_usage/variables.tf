variable "users_role_arn" {
  type        = string
  description = "The ARN of the role to assume for the default provider."
  default     = "arn:aws:iam::123456789012:role/ProvisionAccount"
}

variable "xyz_role_arn" {
  type        = string
  description = "The ARN of the role to assume for the Xyz provider."
  default     = "arn:aws:iam::210987654321:role/ProvisionAccount"
}
