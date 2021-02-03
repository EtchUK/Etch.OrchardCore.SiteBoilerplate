data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_resource_group" "rg_alt" {
  name = var.rg_name_alt != "" ? var.rg_name_alt : var.rg_name
}

data "azurerm_app_service_plan" "sp" {
  name                = var.sp_name
  resource_group_name = data.azurerm_resource_group.rg.name
}


locals {
  project_basic_name = lower(
    replace(format("%s%s", var.env, var.project), "/[^A-Za-z]+/", ""),
  )
  project_hyphenated_name = lower(
    replace(
      replace(format("%s-%s", var.project, var.env), " ", "-"),
      "/[^A-Za-z\\-]+/",
      "",
    ),
  )
  cdn_urls = {for t in var.tenants: "OrchardCore:${t}:OrchardCore_Media:CdnBaseUrl" => "https://${element(random_id.cdn.*.hex, index(var.tenants, t))}.azureedge.net" }
  tenant_settings = {for t in var.tenants: "OrchardCore:${t}:OrchardCore_Media:AssetsRequestPath" => "/media/${t}" }
  app_settings = merge({
    "DashboardConnectionString"                            = azurerm_storage_account.sa.primary_connection_string
    "StorageConnectionString"                              = azurerm_storage_account.sa.primary_connection_string
    "letsencrypt:ClientId"                                 = var.le_client_id
    "letsencrypt:ClientSecret"                             = var.le_client_secret
    "letsencrypt:ResourceGroupName"                        = data.azurerm_resource_group.rg.name
    "letsencrypt:ServicePlanResourceGroupName"             = data.azurerm_resource_group.rg.name
    "letsencrypt:SiteSlot"                                 = ""
    "letsencrypt:SubscriptionId"                           = var.le_subscription_id
    "letsencrypt:Tenant"                                   = var.le_tenant
    "letsencrypt:UseIPBasedSSL"                            = "false"
    "OrchardCore:OrchardCore.Media.Azure:ConnectionString" = azurerm_storage_account.sa.primary_connection_string
    "OrchardCore:OrchardCore.Media.Azure:ContainerName"    = "media"
    "OrchardCore:OrchardCore.Media.Azure:BasePath"         = "{{ ShellSettings.Name }}"
    "WEBSITE_NODE_DEFAULT_VERSION"                         = "6.9.1"
    "WEBSITE_RUN_FROM_PACKAGE"                             = "0"
  }, local.tenant_settings, local.cdn_urls)
}

resource "random_id" "cdn" {
  count = length(var.tenant_urls)
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}

resource "azurerm_app_service" "as" {
  name                = local.project_hyphenated_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_plan_id = data.azurerm_app_service_plan.sp.id
  https_only          = true

  app_settings = local.app_settings

  connection_string {
    name  = "AzureWebJobsDashboard"
    type  = "Custom"
    value = azurerm_storage_account.sa.primary_connection_string
  }

  connection_string {
    name  = "AzureWebJobsStorage"
    type  = "Custom"
    value = azurerm_storage_account.sa.primary_connection_string
  }

  site_config {
    always_on = true
  }
}

resource "azurerm_storage_account" "sa" {
  name = substr(
    local.project_basic_name,
    0,
    min(24, length(local.project_basic_name)),
  )
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_container" "sac" {
  name                  = "media"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "container"
}

resource "azurerm_sql_database" "sd" {
  name                = local.project_hyphenated_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  server_name         = var.sql_server_name

  edition                          = "Standard"
  requested_service_objective_name = var.sql_elastic_pool != "" ? "ElasticPool" : "S0"
  elastic_pool_name                = var.sql_elastic_pool
}

resource "azurerm_app_service_custom_hostname_binding" "hostnames" {
  count               = length(var.hostnames)
  hostname            = var.hostnames[count.index]
  app_service_name    = azurerm_app_service.as.name
  resource_group_name = data.azurerm_resource_group.rg.name

  lifecycle {
    ignore_changes = [
      ssl_state,
      thumbprint
    ]
  }
}

resource "azurerm_cdn_profile" "cp" {
  name                = local.project_hyphenated_name
  location            = data.azurerm_resource_group.rg_alt.location
  resource_group_name = data.azurerm_resource_group.rg_alt.name
  sku                 = "Standard_Verizon"
}

resource "azurerm_cdn_endpoint" "ce" {
  count = length(var.tenant_urls)
  name                = random_id.cdn[count.index].hex
  profile_name        = azurerm_cdn_profile.cp.name
  location            = data.azurerm_resource_group.rg_alt.location
  resource_group_name = data.azurerm_resource_group.rg_alt.name
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

