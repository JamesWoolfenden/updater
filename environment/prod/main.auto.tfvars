name               = "reads3"
subnet_ids         = [""]
security_group_ids = [""]
vpc_id             = ""
envvars = {
  dn          = "platform2" #schema
  du          = "root"
  dh          = ""
  dbp         = "5432"
  account_id  = ""
  incident_id = "johndeere_AWS_123"
  region      = "us-west-2"
  schema      = "platform2"
  secret_id   = "aurora-pg-secret/bc-aurora-rdsv2-secret-rotation"
}
externalroles = [
  "arn:aws:iam::581225519310:role/system-roles/Section31/bridgecrew-custom-policy-updater/bridgecrew-custom-policy-updater-lambda-execution",
  "arn:aws:iam::581225519310:role/ADFS-GSEC-ISG"]



