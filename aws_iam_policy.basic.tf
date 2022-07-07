resource "aws_iam_policy" "basic" {
  name_prefix = "basic"
  path        = "/service-role/"
  policy = jsonencode(
    {
      Statement = [
        {
          Action   = "logs:CreateLogGroup"
          Effect   = "Allow"
          Resource = "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
        },
        {
          Action = [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
          ]
          Effect = "Allow"
          Resource = [
            "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.name}:*",
          ]
        },
      ]
      Version = "2012-10-17"
    }
  )
}



resource "aws_iam_role_policy_attachment" "basic-attach" {
  role       = aws_iam_role.reads3.name
  policy_arn = aws_iam_policy.basic.arn
}

