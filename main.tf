provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "class30" {
  cidr_block = "192.168.0.0/22"

  tags = {
    Name = "class30"
  }
}