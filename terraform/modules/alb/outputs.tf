output "alb_sg_id"         { value = aws_security_group.alb_sg.id }
output "alb_arn"           { value = aws_lb.this.arn }
output "alb_dns_name"      { value = aws_lb.this.dns_name }
output "ecs_tg_arn"        { value = aws_lb_target_group.ecs_tg.arn }
output "listener_http_arn"{ value = aws_lb_listener.http.arn }
output "listener_https_arn"{ value = aws_lb_listener.https.arn }
