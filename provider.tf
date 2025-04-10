terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.53" # 5.53 -> v5.89.0
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}