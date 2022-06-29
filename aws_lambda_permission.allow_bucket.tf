resource "aws_lambda_permission" "allow_bucket" {
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.updater.function_name
  source_account = data.aws_caller_identity.current.account_id
  principal      = "s3.amazonaws.com"
  source_arn     = module.s3.bucket.arn
}


