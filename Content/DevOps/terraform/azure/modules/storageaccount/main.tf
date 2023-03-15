resource "azurerm_storage_account" "sa" {
  name = substr(
    var.name,
    0,
    min(24, length(var.name)),
  )
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind             = "StorageV2"
  allow_blob_public_access = true
}

resource "azurerm_storage_container" "sac" {
  name                  = "media"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "container"
}