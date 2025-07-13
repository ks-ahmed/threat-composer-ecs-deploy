

module "vpc" {
  source          = local.vpc_module_source
  cidr_block      = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  azs             = var.azs
  name_prefix     = var.name_prefix
  subnet_public_ip = var.subnet_public_ip
  routing_cidr_block = var.routing_cidr_block
}

module "acm" {
  source             = local.acm_module_source

  domain             = var.domain
  cloudflare_zone_id = var.cloudflare_zone_id
  name_prefix        = var.name_prefix
  load_balancer_arn  = module.alb.alb_arn
  validation_method  = var.validation_method
  cloudflare_ttl     = var.cloudflare_ttl 

  providers = {
    aws = aws
  }
}

module "alb" {
  source                     = local.alb_module_source
  name_prefix                = var.name_prefix
  internal                   = var.alb_internal
  load_balancer_type         = var.alb_type
  security_group_ids         = var.alb_security_group_ids
  subnet_ids                 = var.public_subnet_ids
  enable_deletion_protection = var.enable_alb_deletion_protection

  target_port                = var.target_port
  target_protocol            = var.target_protocol
  vpc_id                     = var.vpc_id
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
  source      = local.iam_module_source
  name_prefix = var.name_prefix
}


module "ecs" {
  source            = local.ecs_module_source
  name_prefix       = var.name_prefix
  container_name    = var.container_name
  container_image   = var.container_image
  container_port    = var.container_port
  vpc_id            = module.vpc.vpc_id

  desired_count     = var.desired_count
  subnet_ids        = module.vpc.public_subnet_ids
  security_group_ids = [aws_security_group.ecs_sg.id]
  target_group_arn  = module.alb.target_group_arn
  load_balancer_arn = module.alb.alb_arn
  certificate_arn    = module.acm.certificate_arn
  
}

module "cloudflare_dns" {
  source             = local.cloudflare_module_source
  cloudflare_zone_id = var.cloudflare_zone_id
  domain_name        = var.domain
  target             = module.alb.alb_dns_name
  cloudflare_record_type = var.cloudflare_record_type
  cloudflare_record_ttl = var.cloudflare_record_ttl  
  cloudflare_record_proxied = var.cloudflare_record_proxied

}

module "backend" {
  source              = local.backend_module_source
  bucket_name         = var.backend_bucket_name
  dynamodb_table_name = var.backend_dynamodb_table_name
  tags                = var.default_tags
  dynamo_billing_mode = var.dynamo_billing_mode
  dynamo_hash_key     = var.dynamo_hash_key

}
