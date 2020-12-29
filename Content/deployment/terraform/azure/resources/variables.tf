variable "env" {
  description = "Environment descriptor"
}

variable "hostnames" {
  description = "Hostnames to bind to the app service"
  type        = list(string)
  default     = []
}

variable "tenants" {
  description = "Names of tenants"
  type        = list(string)
  default     = []
}

variable "tenant_urls" {
  description = "Primary URL to tenant sites"
  type        = list(string)
  default     = []
}

variable "le_client_id" {
  description = "Lets Encrypt APP ID"
}

variable "le_client_secret" {
  description = "Lets Encrypt App ID"
}

variable "le_subscription_id" {
  description = "Lets Encrypt Subscription ID"
}

variable "le_tenant" {
  description = "Lets Encrypt Tenant"
}

variable "project" {
  description = "Project name for resource names"
  default     = "Orchard Core Site Boilerplate"
}

variable "rg_name" {
  description = "Name of resource group to create infrastructure in"
}

variable "rg_name_alt" {
  description = "Name of alternative resource group to create infrastructure in, used for items like CDN which can only be created in 'major' regions"
  default     = ""
}

variable "sp_name" {
  description = "Name of service plan to create app service in"
}

variable "sql_elastic_pool" {
  description = "Elastic pool to assign SQL database to"
}

variable "sql_server_name" {
  description = "Name of SQL server to create database in"
}

