resource "aws_iam_user" "iam_user" {
  name = var.state_user_name
  path = "/system/"

  tags = {
    Name        = var.state_user_name
    Environment = var.env
    Deployment  = var.deployment
  }
}

resource "aws_iam_access_key" "iam_user_access_key" {
  user = aws_iam_user.iam_user.name
}

resource "aws_iam_user_policy" "iam_user_policy" {
  name   = var.iam_user_policy_name
  user   = aws_iam_user.iam_user.name
  policy = data.template_file.bosh_iam_role_policy.rendered
}