resource "random_id" "cdn" {
  count = length(var.tenant_urls)
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}

resource "azurerm_cdn_profile" "cp" {
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "ce" {
  count                         = length(var.tenant_urls)
  name                          = random_id.cdn[count.index].hex
  profile_name                  = azurerm_cdn_profile.cp.name
  location                      = var.rg_location
  resource_group_name           = var.rg_name
  querystring_caching_behaviour = "UseQueryString"

  lifecycle {
    ignore_changes = [
      global_delivery_rule
    ]
  }

  origin {
    name      = "Custom"
    host_name = var.tenant_urls[count.index]
  }

  origin_host_header = var.tenant_urls[count.index]
}