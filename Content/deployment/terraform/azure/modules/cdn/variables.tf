variable "name" {
  description = "Name of CDN resource"
}

variable "rg_name" {
  description = "Name of resource group to create infrastructure in"
}

variable "rg_location" {
  description = "Location of resource group to create infrastructure in"
}

variable "tenant_urls" {
  description = "Primary URL for tenant sites"
  type        = list(string)
  default     = []
}