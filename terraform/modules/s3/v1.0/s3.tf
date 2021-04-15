resource "aws_s3_bucket" "s3_bucket" {

  bucket        = var.bucket
  acl           = var.access_control_list
  force_destroy = var.force_destroy

  tags = {
    Name        = var.bucket
    Description = var.bucket_description
    Environment = var.environment
    Deployment  = var.deployment
  }

  dynamic "logging" {
    for_each = var.logging_inputs == null ? [] : var.logging_inputs

    content {
      target_bucket = logging.value["target_bucket"]
      target_prefix = logging.value["target_prefix"]
    }
  }

  dynamic "versioning" {
    for_each = var.versioning_inputs == null ? [] : var.versioning_inputs

    content {
      enabled    = versioning.value["enabled"]
      mfa_delete = versioning.value["mfa_delete"]
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule_inputs == null ? [] : var.lifecycle_rule_inputs

    content {
      prefix  = lifecycle_rule.value["prefix"]
      tags    = lifecycle_rule.value["tags"]
      enabled = lifecycle_rule.value["enabled"]

      dynamic "expiration" {
        for_each = lifecycle_rule.value["expiration_inputs"] == null ? [] : lifecycle_rule.value["expiration_inputs"]

        content {
          days = expiration.value["days"]
        }
      }

      dynamic "transition" {
        for_each = lifecycle_rule.value["transition_inputs"] == null ? [] : lifecycle_rule.value["transition_inputs"]

        content {
          days          = transition.value["days"]
          storage_class = transition.value["storage_class"]
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = lifecycle_rule.value["noncurrent_version_transition_inputs"]

        content {
          days          = noncurrent_version_transition.value["days"]
          storage_class = noncurrent_version_transition.value["storage_class"]
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lifecycle_rule.value["noncurrent_version_expiration_inputs"]

        content {
          days = noncurrent_version_expiration.value["days"]
        }
      }
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = var.server_side_encryption_configuration_inputs == null ? [] : var.server_side_encryption_configuration_inputs

    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm     = server_side_encryption_configuration.value["sse_algorithm"]
          kms_master_key_id = server_side_encryption_configuration.value["kms_master_key_id"]
        }
      }
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_block_public_access" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = var.public_access["block_public_acls"]
  block_public_policy     = var.public_access["block_public_policy"]
  ignore_public_acls      = var.public_access["ignore_public_acls"]
  restrict_public_buckets = var.public_access["restrict_public_buckets"]
}
