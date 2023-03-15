provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {}
}

module "resources" {
  source = "./modules"

  env              = var.ENV
  hostnames        = var.HOSTNAMES
  tenants          = var.TENANTS
  tenant_urls      = var.TENANT_URLS
  project          = var.PROJECT
  rg_name          = var.RG_NAME
  rg_name_alt      = var.RG_NAME_ALT
  sp_name          = var.SP_NAME
  sql_elastic_pool = var.SQL_ELASTIC_POOL
  sql_server_name  = var.SQL_SERVER_NAME
  domains          = var.DOMAINS
  dns_rg_name      = var.DNS_RG_NAME
  dns_zone         = var.DNS_ZONE
}
