terraform {
  required_version = "~> 1.9.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.69.0"
    }
  }
  backend "s3" {
    bucket         = "xalts-sparc-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "xalts-sparc-terraform-lock"
  }
}

provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::588738570692:role/AWSTerraformAdminRole"
  }
}
