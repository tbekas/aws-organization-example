resource "aws_iam_user" "this" {
  name = var.name
}

resource "aws_iam_user_login_profile" "this" {
  user    = aws_iam_user.this.name
  pgp_key = var.pgp_key
}

resource "aws_iam_access_key" "this" {
  user    = aws_iam_user.this.name
  pgp_key = var.pgp_key
}

resource "aws_iam_user_group_membership" "this" {
  user = aws_iam_user.this.name

  groups = var.groups
}
