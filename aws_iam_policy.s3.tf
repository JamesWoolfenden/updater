resource "aws_iam_policy" "s3" {
  name_prefix = var.name
  path        = "/service-role/"
  policy = jsonencode(
    {
      Statement = [
        {
          Action   = "s3:GetObject"
          Effect   = "Allow"
          Resource = "${module.s3.bucket.arn}/*"
        },
      ]
      Version = "2012-10-17"
    }
  )
}



resource "aws_iam_role_policy_attachment" "s3-attach" {
  role       = aws_iam_role.reads3.name
  policy_arn = aws_iam_policy.s3.arn
}