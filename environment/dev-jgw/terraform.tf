terraform {
  required_providers {
    aws = {
      version = "4.20.1"
      source  = "hashicorp/aws"
    }
    template = {
      version = "2.2.0"
      source  = "hashicorp/template"
    }
  }
  required_version = ">=1.2.2"
}