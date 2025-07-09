terraform {
  required_version = ">= 1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC module
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

# ACM module (for HTTPS certificate)
module "acm" {
  source  = "./modules/acm"
  domain  = var.domain
  zone_id = var.zone_id
}


# ALB module
module "alb" {
  source          = "./modules/alb"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  certificate_arn = module.acm.cert_arn
}

# ECS module
module "ecs" {
  source                = "./modules/ecs"
  cluster_name          = var.cluster_name
  task_family           = var.task_family
  image_url             = var.image_url
  desired_count         = var.desired_count
  subnets               = module.vpc.public_subnets
  alb_security_group_id = module.alb.alb_security_group_id
  target_group_arn      = module.alb.target_group_arn
}
