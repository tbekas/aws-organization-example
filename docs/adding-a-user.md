# Adding a user

## Install GnuPG

If you already have GnuPG installed and you have your key generated, jump to [exporting the public key](#export-the-public-key), otherwise follow the instructions below.

macOS
```
brew install gnupg
```

Ubuntu
```
sudo apt install gnupg
```

## Generate an encryption key

```
gpg  --generate-key
```

## Export the public key

Export the key and encode it with Base64.
```
gpg --export <public-key-id> | base64
```

The `<public-key-id>` parameter can be found by listing all keys.
```
gpg --list-keys
```

## Create a new user

Open the [users.tf](users.tf) file and create a new instance of a `user` module.
```hcl
module "john_doe" {
  source  = "modules/user"
  name    = "john.doe"
  pgp_key = "<your-exported-key>"

  groups = [
    aws_iam_group.self_managing.name,
    module.developer_group_staging.group_name,
    module.developer_group_production.group_name
  ]

  providers = {
    aws = "aws.users"
  }
}
``` 

Include your user summary in the [output.tf](output.tf) file.
```hcl
output "users_summary" {
  value = [
    module.john_doe.summary,
  ]
}
```

Commit the changes and create a pull request for merging them into the master branch.

## Collect the output from logs

If your pull request was merged a new build should be triggered. Look for the build output and locate the 
`users_summary` section.
```hcl
users_summary = [
  {
    "access_key_id" = "AKIAWS5GSEV382CPXLTL",
    "name" = "john.doe",
    "password" = "<base64-encrypted-password>",
    "secret_access_key" = "<base64-encrypted-access-key>"
  }
]
```
    
## Decrypt the secrets

Decrypt the temporary password and the access key.
```
$ echo '<base64-encrypted-content>' | base64 -D | gpg --decrypt
```

## Login to AWS console

Login to AWS console by clicking the link from the `links` section in the build output. You are going to be asked to change your temporary password.
```
links = {
  "aws_console_sign_in" = "https://<users-account-id>.signin.aws.amazon.com/console/"
  "switch_role_production" = "https://signin.aws.amazon.com/switchrole?account=<production-account-id>&roleName=Developer&displayName=Developer%40production"
  "switch_role_staging" = "https://signin.aws.amazon.com/switchrole?account=<staging-account-id>&roleName=Developer&displayName=Developer%40staging"
}
```

## Configure MFA

Follow the instructions on the [official AWS User Guide](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_users-self-manage-mfa-and-creds.html#tutorial_mfa_step3) to configure the MFA. Remember to sign-out and sign-in again to have MFA enabled.

## Switch role to staging and production

From the `links` section in the build output, click the links to `switch_role_staging` and `switch_role_production`. You should be able to successfully assume `Developer` role on both `staging` and `production` accounts.
```
links = {
  "aws_console_sign_in" = "https://<users-account-id>.signin.aws.amazon.com/console/"
  "switch_role_production" = "https://signin.aws.amazon.com/switchrole?account=<production-account-id>&roleName=Developer&displayName=Developer%40production"
  "switch_role_staging" = "https://signin.aws.amazon.com/switchrole?account=<staging-account-id>&roleName=Developer&displayName=Developer%40staging"
}
```
