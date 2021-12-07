variable "appinsights_connection_string" {
  description = "Connection string for app insights resource"
}

variable "appinsights_instrumentation_key" {
  description = "Instrumentation key for app insights resource"
}

variable "cdn" {
  description = "Collection of CDN ids"
  type        = list(any)
}

variable "name" {
  description = "Name of app service resource"
}

variable "rg_name" {
  description = "Name of resource group to create infrastructure in"
}

variable "rg_location" {
  description = "Location of resource group to create infrastructure in"
}

variable "sp_name" {
  description = "Name of service plan to create app service in"
}

variable "storageaccount_connection_string" {
  description = "Connection string for storage account used to store media"
}

variable "tenants" {
  description = "Names of tenants"
  type        = list(string)
}