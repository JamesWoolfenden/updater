resource "aws_s3_object" "components" {
  bucket = local.full_s3_bucket_name
  key    = "components"
  source = "components.list"
}