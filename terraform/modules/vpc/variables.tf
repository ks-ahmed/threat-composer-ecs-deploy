
variable "public_subnet_suffixes" {
  description = "Suffixes to create public subnet CIDRs"
  type        = list(number)
  default     = [0, 1]
}

variable "private_subnet_suffixes" {
  description = "Suffixes to create private subnet CIDRs"
  type        = list(number)
  default     = [10, 11]
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "cidr_block" { 
  description = "CIDR block for the VPC"
  type        = string

  validation {
    condition     = can(cidrhost(var.cidr_block, 0))
    error_message = "cidr_block must be a valid CIDR notation"
  }
}
