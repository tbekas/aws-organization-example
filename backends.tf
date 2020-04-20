module "backend_staging" {
  source      = "./modules/backend"
  bucket_name = local.terraform_state_bucket_name.staging

  providers = {
    aws = aws.staging
  }
}

module "backend_production" {
  source      = "./modules/backend"
  bucket_name = local.terraform_state_bucket_name.production

  providers = {
    aws = aws.production
  }
}
