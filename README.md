# AWS Organization Example

## About

This repository contains all the necessary code to create:

* AWS organization with three accounts:
  * users
  * staging
  * production
* IAM groups and roles for developers,
* S3 bucket & DynamoDB table for Terraform backend.

## Quickstart

1. Substitute the dummy values in [locals.tf](locals.tf).
1. Optionally add users to [users.tf](users.tf), detailed insttruction on that are in [adding-a-user.md](adding-a-user.md).
1. Initialize the Terraform and apply plan:
    ```
    $ terraform init
    $ terraform apply
    ```
1. Commit the state in `terraform.tfstate` to your repository and you're done!

## Step By step

Follow the instructions on my blog post to get a full explanation on what is being created and how it is configured: https://tbekas.dev/posts/setting-up-an-aws-organization-from-scratch-with-terraform
