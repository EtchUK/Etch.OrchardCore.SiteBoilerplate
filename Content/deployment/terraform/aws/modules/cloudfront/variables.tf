variable "domain_name" {
  description = "DNS domain name of ELB instance"
}

variable "origin_id" {
  description = "Origin for CloudFront distribution"
}

variable "project" {
  description = "Name of project"
}

variable "aliases" {
  type        = list(string)
  description = "List of aliases domains for the Cloudfront distribution"
}

variable "certificate" {
  description = "ARN of the AWS Certificate Manager certificate"
}

variable "origin_protocol_policy" {
  description = "Policy for protocol used by origin on CloudFront"
}

variable "secret_header_name" {
  description = "Name of custom header used to verify CDN is accesing origin"
}

variable "secret_header_value" {
  description = "Value of custom header used to verify CDN is accessing origin"
}

variable "web_acl" {
  description = "ARN of the AWS WAF web ACL to be assigned to CloudFront"
}
