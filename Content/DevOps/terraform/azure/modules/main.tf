locals {
  project_basic_name = lower(
    replace(format("%s%s", var.env, var.project), "/[^A-Za-z]+/", ""),
  )
  project_hyphenated_name = lower(
    replace(
      replace(format("%s-%s", var.project, var.env), " ", "-"),
      "/[^A-Za-z\\-]+/",
      "",
    ),
  )
}

module "resourcegroup" {
  source = "./resourcegroup"

  rg_name     = var.rg_name
  rg_name_alt = var.rg_name_alt
}

module "appinsights" {
  source = "./appinsights"

  name        = local.project_hyphenated_name
  rg_name     = module.resourcegroup.name
  rg_location = module.resourcegroup.location
}

module "storageaccount" {
  source = "./storageaccount"

  name        = local.project_basic_name
  rg_name     = module.resourcegroup.name
  rg_location = module.resourcegroup.location
}

module "cdn" {
  source = "./cdn"

  name        = local.project_hyphenated_name
  rg_name     = module.resourcegroup.name
  rg_location = module.resourcegroup.location
  tenant_urls = var.tenant_urls
}

module "sqldatabase" {
  source = "./sqldatabase"

  name             = local.project_hyphenated_name
  rg_name          = module.resourcegroup.name
  rg_location      = module.resourcegroup.location
  sql_elastic_pool = var.sql_elastic_pool
  sql_server_name  = var.sql_server_name
}

module "appservice" {
  source = "./appservice"

  appinsights_connection_string    = module.appinsights.connection_string
  appinsights_instrumentation_key  = module.appinsights.instrumentation_key
  cdn                              = module.cdn.cdn_ids
  name                             = local.project_hyphenated_name
  rg_name                          = module.resourcegroup.name
  rg_location                      = module.resourcegroup.location
  sp_name                          = var.sp_name
  storageaccount_connection_string = module.storageaccount.primary_connection_string
  tenants                          = var.tenants
}

module "dns" {
  source = "./dns"

  domains         = var.domains
  dns_zone        = var.dns_zone
  rg_name         = var.dns_rg_name
  record          = "${module.appservice.name}.azurewebsites.net"
  verification_id = module.appservice.custom_domain_verification_id
}

module "hostnames" {
  source = "./hostnames"

  app_service_name = module.appservice.name
  hostnames        = var.hostnames
  rg_name          = module.resourcegroup.name
}

module "certificates" {
  source = "./certificates"

  hostnames = module.hostnames.hostnames
}