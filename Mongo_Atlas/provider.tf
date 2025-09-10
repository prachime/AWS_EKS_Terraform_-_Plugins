terraform {
  required_version = "~> 1.9.6"
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.21.4"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.69.0"
    }
  }
  backend "s3" {
    bucket         = "sparc-mongo-atlas-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "sparc-mongo-atlas-terraform-lock"
  }
}

provider "mongodbatlas" {
  public_key  = local.atlas_credentials.public_key
  private_key = local.atlas_credentials.private_key
}

provider "aws" {
  region = "us-east-1"
}

data "aws_secretsmanager_secret" "mongodb_atlas_keys" {
  name = "mongodb-atlas-api-keys"
}

data "aws_secretsmanager_secret_version" "mongodb_atlas_keys" {
  secret_id = data.aws_secretsmanager_secret.mongodb_atlas_keys.id
}

locals {
  atlas_credentials = jsondecode(data.aws_secretsmanager_secret_version.mongodb_atlas_keys.secret_string)
}