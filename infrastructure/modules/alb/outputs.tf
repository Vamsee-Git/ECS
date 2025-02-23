output "alb_arn" {
  value = aws_lb.main.arn
}

output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "patientservice_target_group_arn" {
  value = aws_lb_target_group.patientservice.arn
}

output "appointmentservice_target_group_arn" {
  value = aws_lb_target_group.appointmentservice.arn
}
