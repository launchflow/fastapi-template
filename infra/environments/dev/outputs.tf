
output "service_url" {
  description = "The URL of the deployed service"
  value       = module.app.service_url
}

output "service_account_email" {
  description = "The email of the service account"
  value       = module.app.service_account_email
}
