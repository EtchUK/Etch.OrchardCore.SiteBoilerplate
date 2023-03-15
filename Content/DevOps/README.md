# Deployment Resources

This directory contains resources that are used for Dev Ops.

## Terraform

Under `DevOps/terraform` there are [Terraform](https://www.terraform.io/) scripts which will allow management of infrastructure to be under source control meaning a reduction in confusion about cloud configuration and easier deployment and consistency between different environments.

Terraform has multiple [providers](https://www.terraform.io/docs/providers/index.html) to interface with various cloud environments, this project will add more implementations of this infrastructure as and when we (Etch Play) need them, however we would accept PRs of equivalent infrastructure implemented in different providers.

Current provider implementations:

* Azure - `DevOps/terraform/azure`
* AWS - `DevOps/terraform/aws`

For more detail about Terraform scripts check the provider level `README.md`.

### Provided Infrastructure

#### Azure

The following is a high level overview of the provided infrastructure (with Azure names in brackets):

* Application Instance (App Service)
* Application Insights
* SQL Database
* Storage Account
* CDN 'Server' (CDN Profile)
* CDN Endpoints
* App Service Managed Certificates
* Azure DNS Records

##### SQL

Under `DevOps/sql` you will find a template for a SQL script to execute against your Terraform managed database to generate a user which your Orchard Core sites can use simply replace `<%PROJECT_HYPHENATED_NAME%>` with the name generated in the Terraform script for your project and environment.

#### AWS

The following is a high level overview of provided infrastructure

* VPC
* Elastic Beanstalk Instance
* Elastic File System
* RDS Database (MySQL)
* S3 Bucket
* CloudFront
* AWS WAF
