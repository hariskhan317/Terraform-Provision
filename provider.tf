terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.73"
    }
  }
}
provider "aws" {
  region = var.REGION
}