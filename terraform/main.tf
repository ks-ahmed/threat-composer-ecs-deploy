terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

# VPC module
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  azs                 = var.azs
  name_prefix         = var.name_prefix
}

# ACM module (certificate)
module "acm" {
  source            = "./modules/acm"
  domain            = var.domain
  name_prefix       = var.name_prefix
  cloudflare_zone_id = var.cloudflare_zone_id
}

# ALB module
module "alb" {
  source           = "./modules/alb"
  name_prefix      = var.name_prefix
  vpc_id           = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  certificate_arn  = module.acm.certificate_arn
  target_port      = var.container_port
  health_check_path = "/"
  tags             = var.tags
}

# ECS module
module "ecs" {
  source             = "./modules/ecs"
  name_prefix        = var.name_prefix
  cluster_name       = "${var.name_prefix}-cluster"
  desired_count      = var.desired_count
  image              = var.image
  container_port     = var.container_port
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.alb.alb_security_group_id]
  target_group_arn   = module.alb.target_group_arn
  cpu                = var.cpu
  memory             = var.memory

}

output "alb_dns_name" {
  description = "Application Load Balancer DNS Name"
  value       = module.alb.alb_dns_name
}

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "ECS Service Name"
  value       = module.ecs.service_name
}
