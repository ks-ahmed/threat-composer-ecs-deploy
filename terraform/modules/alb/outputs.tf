output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "DNS name of the Load Balancer"
  value       = aws_lb.this.dns_name
}

output "alb_target_group_arn" {
  description = "ARN of the Target Group"
  value       = aws_lb_target_group.this.arn
}

output "alb_listener_https_arn" {
  description = "ARN of the HTTPS Listener"
  value       = aws_lb_listener.https.arn
}

output "alb_listener_http_arn" {
  description = "ARN of the HTTP Listener"
  value       = aws_lb_listener.http.arn
}

output "alb_security_group_id" {
  description = "Security Group ID for the ALB"
  value       = aws_security_group.alb_sg.id
}
