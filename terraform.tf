/* 
This file defines the terraform block, which Terraform uses to configures itself. 
This block specifies this Terraform configuration must use the aws provider that is within the v4.49.0 minor release. 
It also requires that you use a Terraform version greater than v1.1.0.
See: https://developer.hashicorp.com/terraform/tutorials/modules/module-use
*/

/* The TLS provider provides utilities for working with Transport Layer Security keys and certificates. 
It provides resources that allow private keys, certificates and certificate requests to be created as part of a Terraform deployment.
*/


terraform {

  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.49.0"
    }

    tls = {
      source = "hashicorp/tls"
      version = ">= 3.4"
    }
  }
  
}