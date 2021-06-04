provider "aws" {
  # Our default provider uses our AccountName role
  assume_role {
    role_arn     = var.accountname_role_arn
    session_name = "cool-cdm-cloudtrail-tf-module-example"
  }
  default_tags {
    tags = {
      Testing = true
    }
  }
  region = "us-east-1"
}

provider "aws" {
  # Our "users" provider uses our Users account role
  alias = "users"
  assume_role {
    role_arn     = var.users_role_arn
    session_name = "cool-cdm-cloudtrail-tf-module-example"
  }
  default_tags {
    tags = {
      Testing = true
    }
  }
  region = "us-east-1"
}

#-------------------------------------------------------------------------------
# Configure the example module.
#-------------------------------------------------------------------------------
module "example" {
  source = "../../"
  providers = {
    aws       = aws
    aws.users = aws.users
  }

  assume_role_policy_description = "The IAM policy that allows the CDM user to assume the IAM role that allows access to the CDM CloudTrail data in the AccountName account."
  assume_role_policy_name        = "AccountName-AssumeCdmCloudTrail"
  cdm_user_name                  = "my-cdm-user"
}
