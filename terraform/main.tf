

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
  load_balancer_arn  = module.alb.alb_arn
  validation_method  = var.validation_method
  cloudflare_ttl     = var.cloudflare_ttl 

  providers = {
    aws = aws
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.name_prefix}-ecs-sg"
  description = "Allow HTTP and HTTPS inbound"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "alb" {
  source                     = "./modules/alb"
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



resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.name_prefix}-ecs-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Effect = "Allow"
      Sid    = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${var.name_prefix}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Effect = "Allow"
      Sid    = ""
    }]
  })
}

module "ecs" {
  source            = "./modules/ecs"
  name_prefix       = var.name_prefix
  container_name    = var.container_name
  container_image   = var.container_image
  container_port    = var.container_port
  desired_count     = var.desired_count
  subnet_ids        = module.vpc.public_subnet_ids
  security_group_ids = [aws_security_group.ecs_sg.id]
  target_group_arn  = module.alb.target_group_arn
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn
  load_balancer_arn = module.alb.alb_arn
  certificate_arn    = module.acm.certificate_arn
  
}

module "cloudflare_dns" {
  source             = "./modules/cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  domain_name        = "tm"
  target             = module.alb.alb_dns_name
  cloudflare_record_type = var.cloudflare_record_type
  cloudflare_record_ttl = var.cloudflare_record_ttl  
  cloudflare_record_proxied = var.cloudflare_record_proxied

}

module "backend" {
  source              = "./modules/backend"
  bucket_name         = var.backend_bucket_name
  dynamodb_table_name = var.backend_dynamodb_table_name
  tags                = var.default_tags
  dynamo_billing_mode = var.dynamo_billing_mode
  dynamo_hash_key     = var.dynamo_hash_key

}
