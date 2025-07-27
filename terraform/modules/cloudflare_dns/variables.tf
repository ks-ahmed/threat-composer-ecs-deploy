variable "zone_id" {
  type = string
}

variable "domain" {
  type = string
}

variable "alb_dns" {
  type = string
}

variable "validation_records" {
  type = map(object({
    name  = string
    type  = string
    value = string
  }))
  default = {}
}
