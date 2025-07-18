module "alb" {
  source              = "./modules/alb"
  name_prefix         = var.name_prefix
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  target_port         = var.container_port

}


module "ecs" {
  source           = "./modules/ecs"
  name_prefix      = var.name_prefix
  aws_region       = var.aws_region

  # ECS Cluster & App
  cluster_name = var.cluster_name
  container_image  = var.container_image
  desired_count    = var.desired_count
  container_port   = var.container_port

  # Networking
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids

  # IAM Roles
  execution_role_arn  = module.iam.task_execution_role_arn
  task_role_arn       = module.iam.task_role_arn

  # Load Balancer Integration
  alb_target_group_arn  = module.alb.ecs_tg_arn 
  alb_sg_id    = module.alb.alb_sg_id
  alb_listener_arn      = module.alb.listener_http_arn

  depends_on = [
    module.alb
  ]

}

resource "aws_lb_listener" "https" {
  load_balancer_arn = module.alb.alb_arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = module.acm.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = module.alb.ecs_tg_arn
  }

  depends_on = [
    module.alb,          # Wait for the ALB module fully created
    aws_acm_certificate_validation.acm_validation

 # If you have DNS validation
  ]
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
  source      = "./modules/acm"
  name_prefix = var.name_prefix
  domain_name = var.domain_name
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

  records = concat(
    [
      // CNAME record for app access via tm.vettlyai.com
      {
        name    = "tm"  # this will resolve as tm.vettlyai.com
        type    = "CNAME"
        content = module.alb.alb_dns_name
        ttl     = 1
        proxied = true
      }
    ],
    [
      // ACM DNS validation records
      for dvo in module.acm.domain_validation_options : {
        name    = dvo.resource_record_name
        type    = dvo.resource_record_type
        content = dvo.resource_record_value
        ttl     = 120
        proxied = false
      }
    ]
  )
}

resource "aws_acm_certificate_validation" "acm_validation" {
  certificate_arn = module.acm.certificate_arn

  validation_record_fqdns = [
    for dvo in module.acm.domain_validation_options : dvo.resource_record_name
  ]

  depends_on = [module.cloudflare_dns]
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