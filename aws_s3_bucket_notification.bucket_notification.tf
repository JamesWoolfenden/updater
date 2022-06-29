resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = module.s3.bucket.bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.updater.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

