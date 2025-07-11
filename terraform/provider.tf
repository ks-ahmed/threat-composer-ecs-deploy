terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "aws" {
  alias  = "eu_west_2"
  region = "eu-west-2"
}

provider "cloudflare" {
  
}
