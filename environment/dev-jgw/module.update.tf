module "updater" {
  source             = "../../"
  envvars            = var.envvars
  externalrole       = var.externalrole
  name               = var.name
  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids
  route_table_id     = var.route_table_id
}