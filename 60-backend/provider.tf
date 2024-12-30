terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.0"
    }
  }

  backend "s3" {
    bucket = "expense-infra-remote-state"
    key    = "expense-dev-backend"
    region = "us-east-1"
    dynamodb_table = "expense-infra-locking"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

