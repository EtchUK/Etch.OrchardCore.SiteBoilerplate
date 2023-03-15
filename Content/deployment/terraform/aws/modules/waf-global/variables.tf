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