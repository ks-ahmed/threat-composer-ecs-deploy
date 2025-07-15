

module "vpc" {
  source          = "./modules/vpc"
  cidr_block      = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  azs             = var.azs
  name_prefix     = var.name_prefix
  subnet_public_ip = var.subnet_public_ip
  routing_cidr_block = var.routing_cidr_block
}

module "acm" {
  source             = "./modules/acm"

  domain             = var.domain
  cloudflare_zone_id = var.cloudflare_zone_id
  name_prefix        = var.name_prefix
  validation_method  = var.validation_method
  cloudflare_ttl     = var.cloudflare_ttl 

  providers = {
    aws = aws
  }
}

module "alb" {
  source                     = "./modules/alb"
  name_prefix                = var.name_prefix
  internal                   = var.alb_internal
  load_balancer_type         = var.alb_type
  subnet_ids                 = module.vpc.public_subnet_ids
  enable_deletion_protection = var.enable_alb_deletion_protection

  target_port                = var.target_port
  target_protocol            = var.target_protocol
  vpc_id                     = module.vpc.vpc_id
  tags                       = var.tags
  target_type                = var.target_type

  health_check_path          = var.health_check_path
  health_check_interval      = var.health_check_interval
  health_check_timeout       = var.health_check_timeout
  healthy_threshold          = var.healthy_threshold
  unhealthy_threshold        = var.unhealthy_threshold
  health_check_matcher       = var.health_check_matcher

  https_listener_port        = var.https_listener_port
  https_listener_protocol    = var.https_listener_protocol
  ssl_policy                 = var.ssl_policy
  certificate_arn            = module.acm.certificate_arn


  http_listener_port         = var.http_listener_port
  http_listener_protocol     = var.http_listener_protocol
  redirect_port              = var.redirect_port
  redirect_protocol          = var.redirect_protocol
  redirect_status_code       = var.redirect_status_code
}

module "iam_roles" {
  source      = "./modules/iam_roles"
  name_prefix = var.name_prefix
  execution_role_name = var.execution_role_name
  task_role_name      = var.task_role_name

}


module "ecs" {
  source            = "./modules/ecs"
  name_prefix       = var.name_prefix
  container_name    = var.container_name
  image_url         = var.image_url
  container_port    = var.container_port
  vpc_id            = module.vpc.vpc_id

  desired_count     = var.desired_count
  subnet_ids        = module.vpc.public_subnet_ids
  alb_security_group_id  = module.alb.alb_security_group_id
  target_group_arn  = module.alb.alb_target_group_arn
  load_balancer_arn = module.alb.alb_arn
  certificate_arn    = module.acm.certificate_arn
  execution_role_arn = module.iam_roles.execution_role_arn
  task_role_arn      = module.iam_roles.task_role_arn


}

module "cloudflare_dns" {
  source             = "./modules/cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  domain_name        = var.domain
  target             = module.alb.alb_dns_name
  cloudflare_record_type = var.cloudflare_record_type
  cloudflare_record_ttl = var.cloudflare_record_ttl  
  cloudflare_record_proxied = var.cloudflare_record_proxied

}

module "backend" {
  source = "./modules/backend"

  bucket_name                = var.backend_bucket_name
  tags                       = var.tags
  object_lock_mode           = "GOVERNANCE"
  object_lock_retention_days = 7
}

