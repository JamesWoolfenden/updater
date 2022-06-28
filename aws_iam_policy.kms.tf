resource "aws_kms_key" "s3" {
  enable_key_rotation = true
}

# resource "aws_iam_policy" "kms" {
#   name_prefix = "KMSAccess"
#   path        = "/service-role/"
#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Sid" : "VisualEditor0",
#         "Effect" : "Allow",
#         "Action" : [
#           "kms:GetParametersForImport",
#           "kms:GetPublicKey",
#           "kms:ListKeyPolicies",
#           "kms:ListRetirableGrants",
#           "kms:GetKeyRotationStatus",
#           "kms:GetKeyPolicy",
#           "kms:DescribeKey",
#           "kms:ListResourceTags",
#           "kms:ListGrants"
#         ],
#         "Resource" : "*"
#       },
#       {
#         "Sid" : "VisualEditor1",
#         "Effect" : "Allow",
#         "Action" : [
#           "kms:DescribeCustomKeyStores",
#           "kms:ListKeys",
#           "kms:ListAliases"
#         ],
#         "Resource" : "*"
#       }
#     ]
#   })

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_iam_role_policy_attachment" "kms-attach" {
#   role       = aws_iam_role.reads3.name
#   policy_arn = aws_iam_policy.kms.arn
# }
