terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.9"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "aws-sundbox"

    workspaces {
      name = "tf-ecs-hanson"
    }
  }
}

variable "AWS_ACCESS_KEY" {
  type = string
}
variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_ACCESS_KEY
}
