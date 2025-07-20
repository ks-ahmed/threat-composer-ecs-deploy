module "alb" {
  source            = "./modules/alb"
  name_prefix       = var.name_prefix
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  target_port       = var.container_port
  certificate_arn   = module.acm.certificate_arn  # e.g. from ACM

  depends_on = [aws_acm_certificate_validation.acm_validation]

}


module "ecs" {
  source              = "./modules/ecs"
  name_prefix         = var.name_prefix
  aws_region          = var.aws_region
  cluster_name        = var.cluster_name
  container_image     = var.container_image
  desired_count       = var.desired_count
  container_port      = var.container_port
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  execution_role_arn  = module.iam.task_execution_role_arn
  task_role_arn       = module.iam.task_role_arn
  alb_target_group_arn = module.alb.ecs_tg_arn
  alb_listener_arn     = module.alb.listener_https_arn
  alb_sg_id            = module.alb.alb_sg_id
}



module "vpc" {
  source = "./modules/vpc"  # Adjust path as needed

  cidr_block             = "10.0.0.0/16"
  public_subnet_suffixes = [0, 1]
  private_subnet_suffixes = [10, 11]

  tags = {
    Environment = "dev"
    Project     = "myproject"
  }
}


module "acm" {
  source           = "./modules/acm"
  name_prefix      = var.name_prefix
  domain_name      = var.domain_name
  cloudflare_zone_id = var.cloudflare_zone_id
}



module "iam" {
  source              = "./modules/iam"
  name_prefix         = var.name_prefix

  create_task_role      = true
  task_role_policy_arns = [
    # Example managed policies your app may need
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",          # For reading from S3
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",         # For reading SSM Parameters
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"         # If you want more control over logs
  ]

  tags = {
    Environment = var.name_prefix
  }
}



module "cloudflare_dns" {
  source  = "./modules/cloudflare_dns"
  zone_id = var.cloudflare_zone_id

  records = [
    // CNAME record for app access via tm.vettlyai.com
    {
      name    = "tm"  # this will resolve as tm.vettlyai.com
      type    = "CNAME"
      content = module.alb.alb_dns_name
      ttl     = 1
      proxied = true
    }
  ]
}


module "s3_backend" {
  source       = "./modules/s3"
  bucket_name    = var.terra_bucket_name
  retention_days = 30

  tags = {
    Environment = var.name_prefix
    Project     = "TerraformState"
  }
}