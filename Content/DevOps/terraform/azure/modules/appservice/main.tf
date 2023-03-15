data "azurerm_app_service_plan" "sp" {
  name                = var.sp_name
  resource_group_name = var.rg_name
}

locals {
  cdn_urls        = { for t in var.tenants : "OrchardCore:${t}:OrchardCore_Media:CdnBaseUrl" => "https://${element(var.cdn.*.hex, index(var.tenants, t))}.azureedge.net" }
  tenant_settings = { for t in var.tenants : "OrchardCore:${t}:OrchardCore_Media:AssetsRequestPath" => "/media/${t}" }
  app_settings = merge({
    "APPINSIGHTS_INSTRUMENTATIONKEY"                       = var.appinsights_instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION"                  = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"                  = "1.0.0"
    "APPLICATIONINSIGHTS_CONNECTION_STRING"                = var.appinsights_connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION"           = "~2"
    "DiagnosticServices_EXTENSION_VERSION"                 = "~3"
    "InstrumentationEngine_EXTENSION_VERSION"              = "disabled"
    "OrchardCore:OrchardCore.Media.Azure:ConnectionString" = var.storageaccount_connection_string
    "OrchardCore:OrchardCore.Media.Azure:ContainerName"    = "media"
    "OrchardCore:OrchardCore.Media.Azure:BasePath"         = "{{ ShellSettings.Name }}"
    "SnapshotDebugger_EXTENSION_VERSION"                   = "disabled"
    "WEBSITE_NODE_DEFAULT_VERSION"                         = "6.9.1"
    "XDT_MicrosoftApplicationInsights_BaseExtensions"      = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode"                = "recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk"          = "disabled"
  }, local.tenant_settings, local.cdn_urls)
}

resource "azurerm_app_service" "as" {
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  app_service_plan_id = data.azurerm_app_service_plan.sp.id
  https_only          = true

  app_settings = local.app_settings

  site_config {
    always_on                = true
    dotnet_framework_version = "v5.0"
  }
}