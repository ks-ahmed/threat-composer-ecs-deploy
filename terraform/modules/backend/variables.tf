variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket for Terraform state."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources."
  default     = {}
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "Whether to allow force destroy on the S3 bucket."
}

variable "object_lock_mode" {
  type        = string
  default     = "GOVERNANCE"
  description = "Object lock retention mode. Options: GOVERNANCE or COMPLIANCE"
}

variable "object_lock_retention_days" {
  type        = number
  default     = 7
  description = "Number of days to retain objects in the bucket using object lock."
}
