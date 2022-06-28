module "s3" {
  source                  = "JamesWoolfenden/s3/aws"
  version                 = "0.5.10"
  s3_bucket_force_destroy = false
  s3_bucket_name          = local.full_s3_bucket_name
  s3_bucket_policy        = data.aws_iam_policy_document.basic.json
  mfa_delete              = "Disabled"
  kms_key_id              = ""
  logging                 = []
}


locals {
  full_s3_bucket_name = "dynamic-policy-${data.aws_caller_identity.current.account_id}"
}
