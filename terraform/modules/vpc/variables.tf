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

variable "subnet_public_ip" {
  type = bool
  default = true
  description = "map public ip on launch"
  
}

variable "routing_cidr_block" {
  type = string
  default = "0.0.0.0/0"
  description = "Internet access cidr block"
  
}
