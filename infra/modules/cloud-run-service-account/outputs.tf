
output "service_account_email" {
  description = "The email address of the service account"
  value       = module.service_account.email
}

output "service_account_id" {
  description = "The ID of the service account"
  value       = module.service_account.service_account.id
}
