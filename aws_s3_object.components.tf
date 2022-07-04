resource "aws_s3_object" "components" {
  bucket = local.full_s3_bucket_name
  key    = "components.json"
  source = "${path.module}/components.json"
  depends_on = [
    module.s3
  ]
}