# Minimal Terraform configuration for testing
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Simple AWS provider configuration
provider "aws" {
  region = "us-east-1"
}

# Simple resource for testing
resource "aws_s3_bucket" "test" {
  bucket = "devops-stack-test-${random_id.bucket_suffix.hex}"
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}
