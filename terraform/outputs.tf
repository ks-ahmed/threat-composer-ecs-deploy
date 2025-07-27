

output "ecs_cluster_id" {
  value = module.ecs.cluster_id
}

output "certificate_arn" {
  value = module.acm.certificate_arn
}

output "cloudflare_hostname" {
  value = module.cloudflare_dns.record_fqdn
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
