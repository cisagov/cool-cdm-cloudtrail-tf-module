# ------------------------------------------------------------------------------
# Retrieve the caller identity for the default provider in order to
# get the account ID associated with the account to which we want to
# grant CloudTrail log access for CDM.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "default" {
}

# ------------------------------------------------------------------------------
# Retrieve the caller identity for the "users" provider in order to
# get the account ID associated with the Users account.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "users" {
  provider = aws.users
}

# ------------------------------------------------------------------------------
# Evaluate expressions for use throughout this configuration.
# ------------------------------------------------------------------------------
locals {
  # The account ID for the account to which we want to grant
  # CloudTrail log access for CDM
  account_id = data.aws_caller_identity.default.account_id

  # The account ID for the Users account
  users_account_id = data.aws_caller_identity.users.account_id
}
