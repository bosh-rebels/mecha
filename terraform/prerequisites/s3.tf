module "s3_tfstate" {
  source = "../modules/s3/v1.0"

  environment         = var.env
  bucket              = join("-", [var.env, var.region, var.s3_state_bucket_name])
  bucket_description  = var.s3_state_bucket_description
  access_control_list = var.s3_state_bucket_acl

  versioning_inputs = [
    {
      enabled    = true
      mfa_delete = false
    }
  ]

  server_side_encryption_configuration_inputs = [
    {
      sse_algorithm     = "AES256"
      kms_master_key_id = null
    }
  ]

  logging_inputs        = []
  lifecycle_rule_inputs = []
}

