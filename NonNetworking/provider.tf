terraform {
  required_version = "~> 1.9.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.69.0"
    }
  }
  backend "s3" {
    bucket         = "sparc-infra-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "sparc-infra-terraform-lock"
  }
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/AWSTerraformAdminRole"
  }
}
