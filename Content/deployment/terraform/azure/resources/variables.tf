variable "env" {
  description = "Environment descriptor"
}

variable "hostnames" {
  description = "Hostnames to bind to the app service"
  type    = "list"
  default = []
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
  default = "Orchard Core Site Boilerplate"
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

variable "sql_server_name" {
  description = "Name of SQL server to create database in"
}
