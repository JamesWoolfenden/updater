name               = "reads3"
subnet_ids         = ["subnet-039f2619628623094", "subnet-023834f65ab31e28f"]
security_group_ids = ["sg-0fc2ff0f239eed681"]
vpc_id             = "vpc-03c4ed698fcdf2fef"
envvars = {
  dn          = "platform" #schema
  du          = "root"
  dh          = "bc-aurora-cluster-rdsv2.cluster-czjesf6kpjyz.us-west-2.rds.amazonaws.com"
  dbp         = "5432"
  account_id  = "619572639823"
  incident_id = "jameswoolfen_AWS_123"
  region      = "us-west-2"
  schema      = "platform-anton"
  secret_id   = "aurora-pg-secret/bc-aurora-rdsv2-secret-rotation"
}
externalroles = [
  "arn:aws:iam::944928700026:role/system-roles/Section31/bridgecrew-custom-policy-updater/bridgecrew-custom-policy-updater-lambda-execution",
  "arn:aws:iam::944928700026:role/ADFS-GSEC-ISG"]




