resource "azurerm_app_service_managed_certificate" "certificates" {
  count                      = length(var.hostnames)
  custom_hostname_binding_id = var.hostnames[count.index].id
}


resource "azurerm_app_service_certificate_binding" "bindings" {
  count               = length(var.hostnames)
  hostname_binding_id = var.hostnames[count.index].id
  certificate_id      = azurerm_app_service_managed_certificate.certificates[count.index].id
  ssl_state           = "SniEnabled"
}