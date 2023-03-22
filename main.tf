provider "aws" {
  region = "us-east-2"
}


resource "aws_vpc" "class30" {
  cidr_block = "192.168.0.0/22"

  tags = {
    Name = "class30"
  }

  resource "random_integer" "bucket_suffix" {
    min = 1000
    max = 9999
  }

  resource "aws_kms_key" "var.bucket_key" {
    description = var.kms_key_description
    deletion_window_in_days = 10
  }

  resource "aws_s3_bucket" "var.s3_backend_bucket" {
    bucket = "bootcamp30-${random_integer.bucket_suffix.result}-${var.name_suffix}"
    server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          kms_master_key_id = aws_kms_key.{var.bucket_key}.arn
          sse_algorithm     = "aws:kms"
        }
      }
    }
}