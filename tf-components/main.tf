terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "root-profile" # Using root profile for the sake of this demo. I'm aware that IAM roles would be highly preferred in practice.
}

data "aws_caller_identity" "current" {}
