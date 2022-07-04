data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}/code/"
  output_path = "${path.module}/lambda.zip"
}


data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "basic" {

  statement {
    sid    = "AllowExternalWrite"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [var.externalrole]
    }
    actions =  ["s3:GetObject",
                "s3:PutObject",
                "s3:PutObjectAcl"]
    resources = ["arn:aws:s3:::${local.full_s3_bucket_name}/*"]
  }

  statement {
    sid    = "AllowLambda"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_lambda_function.updater.role]
    }
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${local.full_s3_bucket_name}/*"]
  }

  statement {
    sid    = "DenyHttp"
    effect = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${local.full_s3_bucket_name}/*"]
    condition {
      test     = "StringEquals"
      values   = ["false"]
      variable = "aws:SecureTransport"
    }
  }
}


