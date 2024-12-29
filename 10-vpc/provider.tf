terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.67.0"
    }
  }

  backend "s3" {
    bucket = "devops-practice-state"
    key = "expense-vpc-dev" # using this key we do terraform init, while practicing if u change this key we need to reconfigre--- terraform init -reconfigure
    region = "us-east-1"
    dynamodb_table = "devops-practice-locking"
  }
}

provider "aws" {
  # Configuration options 
  region = "us-east-1"
}