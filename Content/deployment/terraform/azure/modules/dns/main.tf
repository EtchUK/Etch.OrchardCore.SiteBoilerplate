resource "azurerm_dns_cname_record" "dns" {
  count               = length(var.domains)
  name                = var.domains[count.index]
  zone_name           = var.dns_zone
  resource_group_name = var.rg_name
  ttl                 = 300
  record              = var.record
}

resource "azurerm_dns_txt_record" "dns" {
  count               = length(var.domains)
  name                = "asuid.${var.domains[count.index]}"
  zone_name           = var.dns_zone
  resource_group_name = var.rg_name
  ttl                 = 300

  record {
    value = var.verification_id
  }
}