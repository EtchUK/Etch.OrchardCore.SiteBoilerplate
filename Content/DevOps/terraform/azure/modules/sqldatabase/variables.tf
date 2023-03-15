variable "name" {
  description = "Name of SQL database resource"
}

variable "rg_name" {
  description = "Name of resource group to create infrastructure in"
}

variable "rg_location" {
  description = "Location of resource group to create infrastructure in"
}

variable "sql_elastic_pool" {
  description = "Elastic pool to assign SQL database to"
}

variable "sql_server_name" {
  description = "Name of SQL server to create database in"
}

