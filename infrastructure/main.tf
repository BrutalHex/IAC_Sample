module "dehn-app" {
  source      = "./modules/dehn-func"
  location    = var.location
  environment = var.environment
}


