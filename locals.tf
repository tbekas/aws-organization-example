locals {
  account_name = {
    users      = "acme-corp-users"
    staging    = "acme-corp-staging"
    production = "acme-corp-production"
  }

  # Use existing emails, in case of the account recovery
  account_owner_email = {
    users      = "admin+users@acmecorp.com"
    staging    = "admin+staging@acmecorp.com"
    production = "admin+production@acmecorp.com"
  }

  terraform_state_bucket_name = {
    staging    = "acme-corp-terraform-state-staging"
    production = "acme-corp-terraform-state-production"
  }
}