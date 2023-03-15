output "connection_string" {
  value = azurerm_application_insights.appinsights.connection_string
}

output "instrumentation_key" {
  value = azurerm_application_insights.appinsights.instrumentation_key
}