output "function_app_name" {
  value       = azurerm_function_app.dehn.name
  description = "Deployed function app name"
}

output "function_app_default_hostname" {
  value       = azurerm_function_app.dehn.default_hostname
  description = "Deployed function app hostname"
}


output "url" {
  value = "https://${azurerm_function_app.dehn.default_hostname}/api/DehnHttpTrigger"
}