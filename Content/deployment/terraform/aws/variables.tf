variable "ENV" {
  description = "Environment descriptor"
}

variable "PROJECT" {
  description = "Project name for resource names"
  default     = "Orchard Core Site Boilerplate"
}

variable "STACK" {
  description = "Platform used on Elastic Beanstalk instance"
  default     = "64bit Amazon Linux 2 v2.4.3 running .NET Core"
}

variable "AVAILABILITY_ZONE" {
  description = "Availability zone for ELB instance subnet"
}

variable "AVAILABILITY_ZONE_ALTERNATE" {
  description = "Availability zone for ELB instance alternate subnet"
}

variable "DB_USERNAME" {
  description = "Username credential for accessing RDS database"
  default     = "rootuser"
}

variable "DB_PASSWORD" {
  description = "Password credential for accessing RDS database"
}

variable "DOMAINS" {
  type        = list(string)
  description = "List of domains for the Cloudfront distribution"
}

variable "PERMITTED_IPS" {
  type        = list(string)
  description = "List of known IPs that will be able to access sensitive resources"
}

variable "SECRET_HEADER_NAME" {
  description = "Name of custom header used to verify CDN is accesing origin"
}

variable "SECRET_HEADER_VALUE" {
  description = "Value of custom header used to verify CDN is accessing origin"
}

variable "CLOUDFRONT_VIEWER_CERTIFICATE" {
  description = "ARN of the AWS Certificate Manager certificate to be assigned to CloudFront"
}

variable "CLOUDFRONT_WEB_ACL" {
  description = "ARN of the AWS Web ACL that should be assigned to CloudFront"
}

variable "CLOUDFRONT_ORIGIN" {
  description = "Custom origin domain for CloudFront"
}

variable "ELB_INSTANCE_TYPE" {
  description = "Instance type for Elastic Beanstalk instance"
}

variable "RDS_INSTANCE_TYPE" {
  description = "Instance type for RDS instance"
}