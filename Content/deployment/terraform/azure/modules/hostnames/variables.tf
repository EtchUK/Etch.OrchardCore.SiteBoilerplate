variable "app_service_name" {
  description = "Name of app service that hostname binding is associated to"
}

variable "hostnames" {
  description = "Hostnames to bind to the app service"
  type        = list(string)
}

variable "rg_name" {
  description = "Name of resource group to create infrastructure in"
}