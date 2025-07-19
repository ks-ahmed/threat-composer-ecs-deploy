variable "name_prefix" {
  description = "Prefix to apply to IAM resources"
  type        = string
}

variable "create_task_role" {
  description = "Whether to create a task role for ECS"
  type        = bool
  default     = true
}

variable "task_role_policy_arns" {
  description = "List of IAM policy ARNs to attach to the ECS task role"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to all IAM resources"
  type        = map(string)
  default     = {}
}
