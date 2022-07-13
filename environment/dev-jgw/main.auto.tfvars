name               = "reads3"
subnet_ids         = ["subnet-03fdfb13a135366a7", "subnet-05a6a6de2f4989d22", "subnet-08d97e381dbc80d40"]
security_group_ids = ["sg-06db45d8099f7f549"]
vpc_id             = "vpc-0c33dc8cd64f408c4"
envvars = {
  dn          = "platform2"
  du          = "dbgeezer"
  dh          = "platform2.cfkva6djgghs.eu-west-2.rds.amazonaws.com"
  dbp         = "5432"
  account_id  = "680235478471"
  incident_id = "johndeere_AWS_999"
  region      = "eu-west-2"
}
externalroles = ["arn:aws:iam::619572639823:root"]
#this is a db iam role policy 
dbiam_arn = "arn:aws:iam::680235478471:policy/rds-access-dbgeezer20220615082327739100000001"