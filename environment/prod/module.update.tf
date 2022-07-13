module "updater" {
  source             = "../../"
  envvars            = var.envvars
  externalroles      = var.externalroles
  name               = var.name
  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids
}