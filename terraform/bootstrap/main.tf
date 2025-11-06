terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  description = "Région AWS"
  default     = "us-west-1"
}

# Génère un suffixe aléatoire pour rendre le bucket unique
resource "random_id" "suffix" {
  byte_length = 4
}

# On définit un nom de bucket fixe + suffixe
locals {
  bucket_name = "terraform-backend-${random_id.suffix.hex}"
}

resource "aws_s3_bucket" "backend" {
  bucket = local.bucket_name

  tags = {
    Name = "terraform-backend"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.backend.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

output "bucket_name" {
  value = local.bucket_name
}