resource "aws_iam_policy" "secret" {
  name_prefix = "SecretAccess"
  path        = "/service-role/"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : "secretsmanager:GetSecretValue",
          "Resource" : "arn:aws:secretsmanager:*:${data.aws_caller_identity.current.account_id}:secret:*"
        }
      ]
    }
  )
}



resource "aws_iam_role_policy_attachment" "secret-attach" {
  role       = aws_iam_role.reads3.name
  policy_arn = aws_iam_policy.secret.arn
}