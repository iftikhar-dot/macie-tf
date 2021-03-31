provider "aws" {
  region = var.region
  profile = var.profile
}

# get caller identity
data "aws_caller_identity" "current" {}