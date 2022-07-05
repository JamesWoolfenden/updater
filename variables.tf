variable "name" {
  type        = string
  description = "The name of the lambda"
}

variable "route_table_id" {
  type        = string
  description = "Your main route table id"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnets this lambda attaches to"
}

variable "security_group_ids" {
  type        = list(string)
  description = "The security groups this lambda attaches to"
}

variable "envvars" {
  type        = map(any)
  description = "Your lambdas env vars"
}

variable "externalrole" {
  type        = string
  description = "External role to write new tag file"
}

