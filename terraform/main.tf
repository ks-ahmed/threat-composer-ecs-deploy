

module "vpc" {
  source          = "./modules/vpc"
  cidr_block      = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  azs             = var.azs
  name_prefix     = var.name_prefix
}

module "acm" {
  source             = "./modules/acm"

  domain             = var.domain
  cloudflare_zone_id = var.cloudflare_zone_id
  name_prefix        = var.name_prefix
  load_balancer_arn  = module.alb.alb_arn

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
  source            = "./modules/alb"
  name_prefix       = var.name_prefix
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.public_subnet_ids
  security_group_ids = [aws_security_group.ecs_sg.id]
  certificate_arn   = module.acm.certificate_arn
  target_port       = 80
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
}
