# The default provider, which is responsible for creating the
# resources in the account to which we want to grant CloudTrail log
# access.
provider "aws" {
}

# The provider that is used to create the resources in the Users
# account that allow the CDM user to assume a role to access
# CloudTrail logs.
provider "aws" {
  alias = "users"
}
