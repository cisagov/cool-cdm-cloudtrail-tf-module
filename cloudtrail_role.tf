# ------------------------------------------------------------------------------
# Provision the IAM role that can be assumed to access the CDM
# CloudTrail data.
# ------------------------------------------------------------------------------

# Role that can be assumed to access the CDM CloudTrail data.
resource "aws_iam_role" "cloudtrail" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.role_description
  name               = var.role_name
  tags               = var.tags
}

# Attach our policy to this role
resource "aws_iam_role_policy_attachment" "cloudtrail" {
  policy_arn = aws_iam_policy.cloudtrail.arn
  role       = aws_iam_role.cloudtrail.name
}
