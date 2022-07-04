output "endpoint" {
    value=aws_vpc_endpoint.s3
}

output "kms" {
    value = aws_kms_key.s3
}

output "lambda" {
    value = aws_lambda_function.updater
}