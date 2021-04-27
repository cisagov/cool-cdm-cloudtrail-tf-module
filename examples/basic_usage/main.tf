provider "aws" {
  # Our default provider uses our Xyz account role
  assume_role {
    role_arn     = var.xyz_role_arn
    session_name = "cool-cdm-cloudtrail-tf-module-example"
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

  assume_role_policy_description = "The IAM policy that allows the CDM user to assume the IAM role that allows access to the CDM Cloudtrail data in the Xyz account."
  assume_role_policy_name        = "Xyz-AssumeCdmCloudTrail"
  cdm_user_name                  = "my-cdm-user"
  tags = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
}
