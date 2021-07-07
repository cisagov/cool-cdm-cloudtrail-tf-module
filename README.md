# cool-cdm-cloudtrail-tf-module #

[![GitHub Build Status](https://github.com/cisagov/cool-cdm-cloudtrail-tf-module/workflows/build/badge.svg)](https://github.com/cisagov/cool-cdm-cloudtrail-tf-module/actions)

This Terraform module creates the necessary resources to allow the CDM
Splunk user to access and import the CloudTrail logs for an account.
In order to ensure that the CDM Splunk user cannot cause any harm a
separate CloudTrail trail, SNS topic, SQS queue, and S3 bucket are
created for this purpose.  The CDM Splunk user is expected to delete
the CloudTrail logs from the S3 bucket as they are processed.

## Usage ##

```hcl
module "example" {
  source = "github.com/cisagov/cool-cdm-cloudtrail-tf-module"
  providers = {
    aws = aws.accountnameprovisionaccount
    aws.users = aws.usersprovisionaccount
  }

  assume_role_policy_description = "The IAM policy that allows the CDM user to assume the IAM role that allows access to the CDM CloudTrail data in the AccountName account."
  assume_role_policy_name        = "AccountName-AssumeCdmCloudTrail"
  cdm_user_name                  = "my-cdm-user"
}
```

## Examples ##

* [Deploying into the default VPC](https://github.com/cisagov/cool-cdm-cloudtrail-tf-module/tree/develop/examples/default_vpc)

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 3.38 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |
| aws.users | ~> 3.38 |

## Modules ##

No modules.

## Resources ##

| Name | Type |
|------|------|
| [aws_cloudtrail.trail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_iam_policy.cdm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.provisioncdmcloudtrail_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.provisioncdmcloudtrail_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user_policy_attachment.cdm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_s3_bucket.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_sns_topic.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sqs_queue.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.cloudtrail_dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_caller_identity.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.allow_access_to_queue_and_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.allow_cloudtrail_to_publish_to_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.allow_cloudtrail_to_write_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.allow_cloudtrail_topic_to_send_messages](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.allow_users_account_to_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.provisioncdmcloudtrail_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assume\_role\_policy\_description | The description to associate with the IAM policy that allows the CDM user to assume the IAM role that allows access to the CDM CloudTrail data (e.g., "The IAM policy that allows the CDM user to assume the IAM role that allows access to the CDM CloudTrail data in the AccountName account."). | `string` | n/a | yes |
| assume\_role\_policy\_name | The name to associate with the IAM policy that allows the CDM user to assume the IAM role that allows access to the CDM CloudTrail data (e.g., "ACCTNAME-AssumeCdmCloudTrail"). | `string` | n/a | yes |
| aws\_region | The AWS region to deploy into (e.g. "us-east-1"). | `string` | `"us-east-1"` | no |
| bucket\_prefix | A prefix to use when creating a unique name for the S3 bucket where CloudTrail logs will be collected for CDM.  Terraform will create a unique bucket name beginning with the specified prefix. | `string` | `"cdm-cloudtrail-"` | no |
| cdm\_user\_name | The user name of the CDM user who will assume the role to access the CloudTrail data. | `string` | n/a | yes |
| deadletter\_queue\_name | The name of the deadletter queue associated with the SQS queue that collects the messages sent when CloudTrail logs are written to the CDM CloudTrail bucket. | `string` | `"cdm-cloudtrail-deadletter"` | no |
| provisionaccount\_role\_name | The name of the IAM role that allows sufficient permissions to provision all AWS resources in the account. | `string` | `"ProvisionAccount"` | no |
| provisioncdmcloudtrail\_policy\_description | The description of the IAM policy that allows sufficient permissions to provision all CDM CloudTrail AWS resources in the account. | `string` | `"Allows provisioning of the CDM CloudTrail resources in the account."` | no |
| provisioncdmcloudtrail\_policy\_name | The name of the IAM policy that allows sufficient permissions to provision all CDM CloudTrail AWS resources in the account. | `string` | `"ProvisionCdmCloudTrail"` | no |
| queue\_name | The name of the SQS queue that collects the messages sent when CloudTrail logs are written to the CDM CloudTrail bucket. | `string` | `"cdm-cloudtrail"` | no |
| role\_description | The description to assign the IAM role (as well as the corresponding policy) that allows access to the CDM CloudTrail data. | `string` | `"Allows access to the CDM CloudTrail data."` | no |
| role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows access to the CDM CloudTrail data. | `string` | `"CdmCloudTrail"` | no |
| topic\_name | The name of the SNS topic that sends a message when CloudTrail logs are written to the CDM CloudTrail bucket. | `string` | `"cdm-cloudtrail"` | no |
| trail\_name | The name of the CloudTrail trail that generates the information for import into CDM. | `string` | `"cdm-cloudtrail"` | no |

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

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, these are the main directory and
every directory under `examples/`.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
