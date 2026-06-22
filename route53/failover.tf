resource "aws_route53_record" "primary" {
  zone_id = var.zone_id
  name    = "app.example.com"
  type    = "A"
  
  failover_routing_policy {
    type = "PRIMARY"
  }
  
  set_identifier  = "primary"
  health_check_id = aws_route53_health_check.primary.id
  
  alias {
    name    = aws_lb.primary.dns_name
    zone_id = aws_lb.primary.zone_id
  }
}

resource "aws_route53_health_check" "primary" {
  fqdn              = "app-primary.example.com"
  port               = 443
  type               = "HTTPS"
  failure_threshold  = 3
  request_interval   = 10
}
