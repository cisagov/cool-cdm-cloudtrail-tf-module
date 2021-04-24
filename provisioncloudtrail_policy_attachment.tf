# ------------------------------------------------------------------------------
# Attach the IAM policy that allows sufficient permissions to
# provision the CloudTrail-related resources for CDM access.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisioncdmcloudtrail_policy_attachment" {
  policy_arn = aws_iam_policy.provisioncdmcloudtrail_policy.arn
  role       = var.provisionaccount_role_name
}
