terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.region
}

# VPC module
module "vpc" {
  source             = "./modules/vpc"
  name_prefix        = var.name_prefix
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  azs                = var.azs
}

# ALB module
module "alb" {
  source           = "./modules/alb"
  name_prefix      = var.name_prefix
  vpc_id           = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  certificate_arn  = var.alb_certificate_arn
}

# ECS module
module "ecs" {
  source             = "./modules/ecs"
  name_prefix        = var.name_prefix
  cluster_name       = "${var.name_prefix}-cluster"
  desired_count      = var.desired_count
  image              = var.container_image
  container_port     = 80
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.alb.alb_sg_id]
  target_group_arn   = module.alb.target_group_arn
  cpu                = "256"
  memory             = "512"
}

# Optional: ECR module (if you want Terraform to manage your repo)
module "ecr" {
  source      = "./modules/ecr"
  name        = var.name_prefix
}
