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

terraform { 
    
    backend "s3" {
     bucket        = "threat-composer-bucket"
     key           = "ecs-threat-composer/terraform.tfstate"
     region        = "eu-west-2"
     
   }
}

provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
