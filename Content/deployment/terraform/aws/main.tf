terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

provider "aws" {
  alias   = "cloudfront-global"
  profile = "default"
  region  = "us-east-1"
}

terraform {
  backend "s3" {}
}

locals {
  project_basic_name = lower(
    replace(format("%s%s", var.PROJECT, var.ENV), "/[^A-Za-z]+/", ""),
  )
  project_hyphenated_name = lower(
    replace(
      replace(format("%s-%s", var.PROJECT, var.ENV), " ", "-"),
      "/[^A-Za-z\\-]+/",
      "",
    ),
  )
}

module "network" {
  source = "./modules/network"

  project                     = local.project_hyphenated_name
  availability_zone           = var.AVAILABILITY_ZONE
  availability_zone_alternate = var.AVAILABILITY_ZONE_ALTERNATE
}

module "waf-regional" {
  source = "./modules/waf-regional"

  env                 = var.ENV
  project             = local.project_hyphenated_name
  permitted_ips       = var.PERMITTED_IPS
  secret_header_name  = var.SECRET_HEADER_NAME
  secret_header_value = var.SECRET_HEADER_VALUE
}

module "waf-global" {
  providers = {
    aws = aws.cloudfront-global
  }
  source = "./modules/waf-global"

  env           = var.ENV
  project       = local.project_hyphenated_name
  permitted_ips = var.PERMITTED_IPS
}

module "rds" {
  source = "./modules/rds"

  project             = local.project_hyphenated_name
  db_name             = local.project_basic_name
  db_username         = var.DB_USERNAME
  db_password         = var.DB_PASSWORD
  private_subnet_id_1 = module.network.rds_private_subnet_id_1
  private_subnet_id_2 = module.network.rds_private_subnet_id_2
  security_group_id   = module.network.rds_security_group_id
  instance_class      = var.RDS_INSTANCE_TYPE
}

module "s3" {
  source = "./modules/s3"

  project = local.project_hyphenated_name
}

module "elasticbeanstalk" {
  source = "./modules/elasticbeanstalk"

  project             = local.project_hyphenated_name
  security_group_id   = module.network.app_security_group_id
  stack               = var.STACK
  subnet_id           = module.network.subnet_id
  alternate_subnet_id = module.network.alternate_subnet_id
  vpc_id              = module.network.vpc_id
  instance_type       = var.ELB_INSTANCE_TYPE
}

module "elasticfilesystem" {
  source = "./modules/elasticfilesystem"

  project             = local.project_hyphenated_name
  security_group_id   = module.network.app_security_group_id
  subnet_id           = module.network.subnet_id
  alternate_subnet_id = module.network.alternate_subnet_id
}

module "cloudfront" {
  source = "./modules/cloudfront"

  project                = local.project_hyphenated_name
  aliases                = var.DOMAINS
  certificate            = var.CLOUDFRONT_VIEWER_CERTIFICATE
  domain_name            = var.CLOUDFRONT_ORIGIN != "" ? var.CLOUDFRONT_ORIGIN : module.elasticbeanstalk.elb_dns
  origin_id              = var.CLOUDFRONT_ORIGIN != "" ? var.CLOUDFRONT_ORIGIN : module.elasticbeanstalk.elb_id
  origin_protocol_policy = var.CLOUDFRONT_ORIGIN != "" ? "https-only" : "http-only"
  secret_header_name     = var.SECRET_HEADER_NAME
  secret_header_value    = var.SECRET_HEADER_VALUE
  web_acl                = var.CLOUDFRONT_WEB_ACL != "" ? var.CLOUDFRONT_WEB_ACL : module.waf-global.cloudfront_ip_restriction_arn
}
