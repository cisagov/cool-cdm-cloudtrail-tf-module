# ------------------------------------------------------------------------------
# Attach the IAM policy that allows sufficient permissions to
# provision the CloudTrail-related resources for CDM access.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisioncloudtrail_policy_attachment" {
  policy_arn = aws_iam_policy.provisioncloudtrail_policy.arn
  role       = var.provisionaccount_role_name
}
