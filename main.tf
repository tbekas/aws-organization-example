provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.users.id}:role/Admin"
  }

  alias  = "users"
  region = "eu-central-1"
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.staging.id}:role/Admin"
  }

  alias  = "staging"
  region = "eu-central-1"
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.production.id}:role/Admin"
  }

  alias  = "production"
  region = "eu-central-1"
}

resource "aws_organizations_organization" "organization" {
}

resource "aws_organizations_account" "users" {
  name      = local.account_name["users"]
  email     = local.account_owner_email["users"]
  role_name = "Admin"
}

resource "aws_organizations_account" "staging" {
  name      = local.account_name["staging"]
  email     = local.account_owner_email["staging"]
  role_name = "Admin"
}

resource "aws_organizations_account" "production" {
  name      = local.account_name["production"]
  email     = local.account_owner_email["production"]
  role_name = "Admin"
}

