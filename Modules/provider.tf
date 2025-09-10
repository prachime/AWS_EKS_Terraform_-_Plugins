terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.7.0"
    }
  }
  backend "s3" {
    bucket         = "csstech-infra-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "csstech-infra-terraform-lock"
  }
}

provider "aws" {
  region           = var.region
  assume_role {
    role_arn       = var.role_arn
    session_name   = var.session_name
  }
}
