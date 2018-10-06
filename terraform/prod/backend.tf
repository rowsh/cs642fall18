terraform {
  backend "s3" {
    bucket = "cs642"
    key    = "prod/terraform.tfstate"
    encrypt = "true"
    region = "us-east-1"
    dynamodb_table = "cs642"
    profile = "shu"
  }

  versioning {
      enabled = true
    }

  lifecycle {
    prevent_destroy = true
  }
}
