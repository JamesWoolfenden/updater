module "s3" {
  source = "git::https://github.com/JamesWoolfenden/terraform-aws-s3.git?ref=7115546980e3e3ebc700149bb3c03be58a153f0d" #v0.5.25
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
