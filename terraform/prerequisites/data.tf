data "template_file" "bosh_iam_role_policy" {
  template = file("files/policies/genesis-eu-west-1-tf-state-user-policy.json")
  vars = {
    state_bucket_arn = module.s3_tfstate.bucket_arn
  }
}