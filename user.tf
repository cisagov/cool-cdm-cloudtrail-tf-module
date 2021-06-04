# ------------------------------------------------------------------------------
# Create an IAM policy document that allows the users account to
# assume this role.
# ------------------------------------------------------------------------------

# Policy document with the necessary permissions to assume the role
# that allows access to the CDM CloudTrail data.
data "aws_iam_policy_document" "allow_users_account_to_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]
    effect = "Allow"
    resources = [
      aws_iam_role.cloudtrail.arn,
    ]
  }
}

# Policy with the necessary permissions to assume the role that allows
# access to the CDM CloudTrail data.
resource "aws_iam_policy" "cdm" {
  provider = aws.users

  description = var.assume_role_policy_description
  name        = var.assume_role_policy_name
  policy      = data.aws_iam_policy_document.allow_users_account_to_assume_role.json
}

# Attach our policy to the CDM user
resource "aws_iam_user_policy_attachment" "cdm" {
  provider = aws.users

  policy_arn = aws_iam_policy.cdm.arn
  user       = var.cdm_user_name
}
