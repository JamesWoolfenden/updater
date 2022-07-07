resource "aws_iam_policy" "kms" {
  name_prefix = "KMSAccess"
  path        = "/service-role/"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : [
            "kms:DescribeKey",
          ],
          "Resource" : "arn:aws:kms:*:${data.aws_caller_identity.current.account_id}:key/*"
        },
        {
          "Sid" : "VisualEditor2",
          "Effect" : "Allow",
          "Action" : "kms:Decrypt",
          "Resource" : "arn:aws:kms:*:${data.aws_caller_identity.current.account_id}:key/*"
        }
      ]
    }
  )
}



resource "aws_iam_role_policy_attachment" "kms-attach" {
  role       = aws_iam_role.reads3.name
  policy_arn = aws_iam_policy.kms.arn
}