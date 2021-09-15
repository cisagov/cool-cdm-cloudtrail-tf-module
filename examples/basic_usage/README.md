# Example Terraform Code #

## Usage ##

To run this example you need to execute the `terraform init` command
followed by the `terraform apply` command.

Note that this example may create resources which cost money. Run
`terraform destroy` when you no longer need these resources.

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.14.0 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| example | ../../ | n/a |

## Resources ##

No resources.

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| accountname\_role\_arn | The ARN of the role to assume for the AccountName provider. | `string` | `"arn:aws:iam::210987654321:role/ProvisionAccount"` | no |
| users\_role\_arn | The ARN of the role to assume for the default provider. | `string` | `"arn:aws:iam::123456789012:role/ProvisionAccount"` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| access\_policy | The IAM policy with the necessary permissions to access the CDM CloudTrail data. |
| access\_role | The IAM role that can be assumed to access the CDM CloudTrail data. |
| assume\_access\_role\_policy | The IAM policy that allows the CDM user to assume the IAM role that allows access the CDM CloudTrail data. |
| bucket | The S3 bucket where CloudTrail logs are stored for CDM. |
| deadletter\_queue | The SQS deadletter queue of messages notifying of CloudTrail logs being written to the CDM S3 bucket for which processing has failed. |
| queue | The SQS queue of messages notifying of CloudTrail logs being written to the CDM S3 bucket. |
| topic | The SNS topic for notifications of CloudTrail logs being written to the CDM S3 bucket. |
| trail | The CloudTrail trail for CDM. |
