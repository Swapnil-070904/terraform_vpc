output "lb_endpoint" {
  value = "Click here to access your server ${aws_lb.app_lb.dns_name}"
}