resource "azurerm_sql_database" "sd" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.rg_location
  server_name         = var.sql_server_name

  edition                          = "Standard"
  requested_service_objective_name = var.sql_elastic_pool != "" ? "ElasticPool" : "S0"
  elastic_pool_name                = var.sql_elastic_pool
}