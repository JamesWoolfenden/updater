module "s3" {
  source = "git::https://github.com/JamesWoolfenden/terraform-aws-s3.git?ref=d04e4a0a6c9f0c1864ee0f62d5f817a0bf01b274" #v0.5.10
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
