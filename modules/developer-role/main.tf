resource "aws_iam_role" "this" {
  name = "Developer"

  assume_role_policy = data.template_file.trust_relationship.rendered
}

data "template_file" "trust_relationship" {
  template = file("${path.module}/trust_relationship.tpl")

  vars = {
    trusted_entity = var.trusted_entity
  }
}

resource "aws_iam_role_policy_attachment" "administrator_access" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.this.name
}
