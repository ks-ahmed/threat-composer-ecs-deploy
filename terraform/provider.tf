terraform {
  backend "s3" {
    bucket         = "vettlyai-tf-state-prod"
    key            = "vettlyai/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

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
  api_token = var.cloudflare_api_token
}
