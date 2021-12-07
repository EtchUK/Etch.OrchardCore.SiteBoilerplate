data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_resource_group" "rg_alt" {
  name = var.rg_name_alt != "" ? var.rg_name_alt : var.rg_name
}