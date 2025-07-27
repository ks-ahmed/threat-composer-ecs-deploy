output "dns_name" {
  description = "The DNS name of the ALB"
  value = aws_lb.main.dns_name

}

output "target_group_arn" {
  value = aws_lb_target_group.app.arn
  description = "The target group ARN for the ECS service"
}

output "security_group_id" {
  value = aws_security_group.alb.id
  description = "The ALB security group ID"
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value = aws_lb.main.dns_name
}