variable "rg_name" {
  description = "Name of resource group to create infrastructure in"
}

variable "rg_name_alt" {
  description = "Name of alternative resource group to create infrastructure in, used for items like CDN which can only be created in 'major' regions"
  default     = ""
}