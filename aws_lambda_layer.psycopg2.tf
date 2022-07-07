
resource "aws_lambda_layer_version" "psycopg2" {
  filename            = "${path.module}/layer/mylayer.zip"
  layer_name          = "psycopg2"
  description         = "SQL library psycopg2"
  compatible_runtimes = ["python3.8"]
  source_code_hash    = filebase64sha256("${path.module}/layer/mylayer.zip")
}