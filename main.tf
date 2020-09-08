provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

data "aws_availability_zones" "available" {
  state = "available"
}

terraform {
  backend "s3" {
    bucket = "ecs-playground"
    key    = "ecs-playground.tfstate"
    region = "eu-central-1"
  }
}