

output "url" {
  value = "https://${module.dehn-app.function_app_default_hostname}/api/DehnHttpTrigger"
}

