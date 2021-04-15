data "aws_iam_instance_profile" "bosh" {
  name  = var.bosh_iam_instance_profile
  count = local.iamProfileProvided
}

data "template_file" "bosh_iam_role_policy" {
  template = file("files/policies/bosh_iam_role_policy.json")
}

data "template_file" "flog_logs_role_policy" {
  template = file("files/policies/flow_logs_role_policy.json")
}