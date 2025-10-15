provider "aws" {
  region = "ap-southeast-1"
  # shared_credentials_files = ["~/.aws/credentials"]
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

