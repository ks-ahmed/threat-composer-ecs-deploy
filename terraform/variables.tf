variable "aws_region" {
  type = string
  default = "eu-west-2"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["eu-west-2a", "eu-west-2b"]
}

variable "domain_name" {
  description = "App domain like app.example.com"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "container_image" {
  type    = string
  default = ""
}

variable "vpc_name" {
    type = string
    description = "tag name of VPC"
    default = "main"
}

variable "iam_name" {
    type = string
    description = "tag name of VPC"
    default = "ecs-threat-model"
}