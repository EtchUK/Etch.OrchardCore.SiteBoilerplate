variable "domains" {
  description = "List of domains to add cnames for"
  type        = list(string)
  default     = []
}

variable "dns_zone" {
  description = "Domain that cname records are added to"
}

variable "record" {
  description = "The target of the CNAME"
}

variable "rg_name" {
  description = "Name of resource group to create infrastructure in"
}

variable "verification_id" {
  description = "Domain verification ID used for TXT records"
}