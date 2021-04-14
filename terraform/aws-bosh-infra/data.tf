data "aws_iam_instance_profile" "bosh" {
  name = var.bosh_iam_instance_profile
  count = local.iamProfileProvided
}