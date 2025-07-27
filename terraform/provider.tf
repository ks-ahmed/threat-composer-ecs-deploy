
terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

#terraform {
#  backend "s3" {
#    bucket         = "your-tf-state-bucket"
#    key            = "ecs-assignment/terraform.tfstate"
#    region         = "eu-west-2"
#    state_locking  = true  # enabled by default now
#    consistency    = "strong" # Optional but recommended
#  }
#s}
