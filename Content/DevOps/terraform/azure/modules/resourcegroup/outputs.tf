output "name" {
  value = data.azurerm_resource_group.rg.name
}

output "location" {
  value = data.azurerm_resource_group.rg.location
}

output "alt_name" {
  value = data.azurerm_resource_group.rg_alt.name
}

output "alt_location" {
  value = data.azurerm_resource_group.rg_alt.location
}