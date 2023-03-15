variable "env" {
  description = "Environment descriptor"
}

variable "project" {
  description = "Name of project"
}

variable "permitted_ips" {
  type        = list(string)
  description = "List of IPs to be added to set."
}

variable "secret_header_name" {
  description = "Name of custom header used to verify CDN is accesing origin"
}

variable "secret_header_value" {
  description = "Value of custom header used to verify CDN is accessing origin"
}