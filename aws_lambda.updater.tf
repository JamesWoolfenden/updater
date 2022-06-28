resource "aws_lambda_function" "updater" {
  # checkov:skip=CKV_AWS_115: ADD REASON
  # checkov:skip=CKV_AWS_116: ADD REASON
  role             = aws_iam_role.reads3.arn
  function_name    = var.name
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  layers           = ["arn:aws:lambda:eu-west-2:680235478471:layer:psycopg2:11"]
  filename         = data.archive_file.lambda.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda.output_path)
  kms_key_arn      = aws_kms_key.s3.arn

  memory_size = 256
  timeout     = 15

  architectures = [
    "x86_64",
  ]
  tracing_config {
    mode = "PassThrough"
  }
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  environment {
    variables = var.envvars
  }
}

