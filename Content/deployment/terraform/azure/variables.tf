variable "ENV" {
  description = "Environment descriptor"
}

variable "HOSTNAMES" {
  description = "Hostnames to bind to the app service"
  type        = "list"
  default     = []
}

variable "LE_CLIENT_ID" {
  description = "Lets Encrypt APP ID"
}

variable "LE_CLIENT_SECRET" {
  description = "Lets Encrypt App ID"
}

variable "LE_SUBSCRIPTION_ID" {
  description = "Lets Encrypt Subscription ID"
}

variable "LE_TENANT" {
  description = "Lets Encrypt Tenant"
}

variable "PROJECT" {
  description = "Project name for use in resource names"
  default     = "Orchard Core Site Boilerplate"
}

variable "RG_NAME" {
  description = "Name of resource group to create infrastructure in"
}

variable "RG_NAME_ALT" {
  description = "Name of alternative resource group to create infrastructure in, used for items like CDN which can only be created in 'major' regions"
  default     = ""
}

variable "SP_NAME" {
  description = "Name of service plan to create app service in"
}

variable "SQL_ELASTIC_POOL" {
  description = "Name of Elastic Pool to create database in"
}

variable "SQL_SERVER_NAME" {
  description = "Name of SQL server to create database in"
}
