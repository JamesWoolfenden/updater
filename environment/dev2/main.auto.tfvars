name               = "reads3"
route_table_id     = "rtb-09b1a4a1ae5f60899"
subnet_ids         = ["subnet-039f2619628623094", "subnet-023834f65ab31e28f"]
security_group_ids = ["sg-0fc2ff0f239eed681"]
vpc_id             = "vpc-03c4ed698fcdf2fef"
envvars = {
  dn          = "platform" #schema
  du          = "root"
  dh          = "bc-aurora-cluster-rdsv2.cluster-czjesf6kpjyz.us-west-2.rds.amazonaws.com"
  dbp         = "5432"
  account_id  = "619572639823"
  incident_id = "johndeere_AWS_999"
  region      = "us-west-2"
  schema      = "platform-anton"
  secret_id   = "aurora-pg-secret/bc-aurora-rdsv2-secret-rotation"
}
externalrole = "arn:aws:iam::680235478471:root"



