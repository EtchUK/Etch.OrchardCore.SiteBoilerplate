provider "azurerm" {
  version = "~> 1.25"
}

terraform {
  backend "azurerm" {}
}

module "resources" {
  source = "./resources"

  env                = "${var.ENV}"
  hostnames          = "${var.HOSTNAMES}"
  le_client_id       = "${var.LE_CLIENT_ID}"
  le_client_secret   = "${var.LE_CLIENT_SECRET}"
  le_subscription_id = "${var.LE_SUBSCRIPTION_ID}"
  le_tenant          = "${var.LE_TENANT}"
  project            = "${var.PROJECT}"
  rg_name            = "${var.RG_NAME}"
  rg_name_alt        = "${var.RG_NAME_ALT}"
  sp_name            = "${var.SP_NAME}"
  sql_elastic_pool   = "${var.SQL_ELASTIC_POOL}"
  sql_server_name    = "${var.SQL_SERVER_NAME}"
}
