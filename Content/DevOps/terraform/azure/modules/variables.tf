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

variable "project" {
  description = "Project name for resource names"
  default     = "Example Project"
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

variable "domains" {
  description = "List of domains to add cnames for"
  type        = list(string)
  default     = []
}

variable "dns_rg_name" {
  description = "Resource group for DNS zone"
}


variable "dns_zone" {
  description = "Domain that cname records are added to"
}
