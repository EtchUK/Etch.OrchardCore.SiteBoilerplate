resource "azurerm_app_service_custom_hostname_binding" "hostnames" {
  count               = length(var.hostnames)
  hostname            = var.hostnames[count.index]
  app_service_name    = var.app_service_name
  resource_group_name = var.rg_name

  lifecycle {
    ignore_changes = [
      ssl_state,
      thumbprint
    ]
  }
}