output "alb_url" {
  description = "URL to access the app"
  value       = "https://${module.alb.alb_dns_name}"
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

