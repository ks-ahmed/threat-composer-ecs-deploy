terraform {
#  backend "s3" {
#    bucket         = "vettlyai-tf-state-prod"
#    key            = "vettlyai/terraform.tfstate"
#    region         = "eu-west-2"
#    encrypt        = true
   
#  }

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

provider "aws" {
  alias  = "eu_west_2"
  region = "eu-west-2"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
