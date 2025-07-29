variable "name" {
  description = "Base name for VPC and related resources"
  type        = string
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}
