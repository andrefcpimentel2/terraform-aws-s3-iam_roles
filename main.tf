variable "aws_region" {
  description = "AWS region"
  default = "eu-west-2"
}

variable "namespace" {
  description = "name to pass to Name tag"
  default = "andredemo-iam"
}

provider "aws" {
  region = var.aws_region
  assume_role { 

    role_arn = var.role_arn 

  } 
}

resource "aws_s3_bucket" "s3_iam" {
  bucket = "${var.namespace}-s3-bucket"
  acl    = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags = {
    Name       = "${var.namespace}-s3-iam"
    created-by = Terraform
  }

}

output "bucket_arn" {
  value = aws_s3_bucket.s3_iam.arn
}
