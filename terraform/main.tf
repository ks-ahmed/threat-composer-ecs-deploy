
module "vpc" {
  source = "./modules/vpc"
  name = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = var.azs
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs = var.public_subnet_cidrs
  
}

module "acm" {
  source  = "./modules/acm"
  domain  = var.domain_name
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  certificate_arn   = module.acm.certificate_arn
}

module "iam" {
  source = "./modules/iam"
  name = var.iam_name
}

module "ecs" {
  source                = "./modules/ecs"
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnets
  alb_target_group_arn  = module.alb.target_group_arn
  alb_security_group_id = module.alb.security_group_id
  container_image       = var.container_image
  execution_role_arn    = module.iam.execution_role_arn
  task_role_arn         = module.iam.task_role_arn

  depends_on = [module.alb]  
}

module "cloudflare_dns" {
  source = "./modules/cloudflare_dns"

  zone_id = var.cloudflare_zone_id
  domain  = var.domain_name
  alb_dns = module.alb.dns_name
  

  validation_records = {
    for dvo in module.acm.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }
}

module "acm_validation" {
  source = "./modules/acm_validation"

  certificate_arn         = module.acm.certificate_arn
  validation_record_fqdns = module.cloudflare_dns.validation_fqdns
}


