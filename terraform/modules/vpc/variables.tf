variable "cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDRs"
}

variable "azs" {
  type        = list(string)
  description = "Availability zones for subnets"
}

variable "name_prefix" {
  type        = string
}
