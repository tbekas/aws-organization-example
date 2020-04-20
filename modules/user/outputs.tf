output "summary" {
  value = {
    name              = var.name
    password          = aws_iam_user_login_profile.this.encrypted_password
    access_key_id     = aws_iam_access_key.this.id
    secret_access_key = aws_iam_access_key.this.encrypted_secret
  }
}
