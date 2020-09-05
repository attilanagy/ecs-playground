output "app_service_dns_name" {
  description = "The DNS name for app service's load-balancer."
  value       = module.app_service.dns_name
}

output "web_service_dns_name" {
  description = "The DNS name for web service's load-balancer."
  value       = module.web_service.dns_name
}