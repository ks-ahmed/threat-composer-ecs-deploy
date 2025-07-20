variable "name_prefix" { type = string }
variable "vpc_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "target_port" { type = number }
variable "certificate_arn" { type = string }
