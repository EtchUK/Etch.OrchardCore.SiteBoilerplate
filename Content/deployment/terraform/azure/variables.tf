variable "ENV" {
  description = "Environment descriptor"
}

variable "HOSTNAMES" {
  description = "Hostnames to bind to the app service"
  type        = list(string)
  default     = []
}

variable "TENANTS" {
  description = "Names of tenants"
  type        = list(string)
  default     = []
}

variable "TENANT_URLS" {
  description = "Primary URL to tenant sites"
  type        = list(string)
  default     = []
}

variable "PROJECT" {
  description = "Project name for resource names"
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
  description = "Elastic pool to assign SQL database to"
}

variable "SQL_SERVER_NAME" {
  description = "Name of SQL server to create database in"
}

