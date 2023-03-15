resource "azurerm_application_insights" "appinsights" {
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  application_type    = "web"
}