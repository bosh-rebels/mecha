variable "bucket" {
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name."
}

variable "access_control_list" {
  type        = string
  description = "(Optional) The canned ACL to apply. Defaults to private."
}

variable "bucket_description" {
  type        = string
  description = "This is the bucket description"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "deployment" {
  description = "How this resource is created"
  type        = string
  default     = "Terraform"
}

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "logging_inputs" {
  description = "S3 logging configuration"
  type = list(object({
    target_bucket = string
    target_prefix = string
  }))
  default = null
}

variable "versioning_inputs" {
  description = "S3 versioning configuration"
  type = list(object({
    enabled    = bool
    mfa_delete = bool
  }))
  default = [
    {
      enabled    = true
      mfa_delete = null
  }]
}

variable "lifecycle_rule_inputs" {
  description = "S3 lifecycle rules configuration"
  type = list(object({
    prefix                                 = string
    tags                                   = map(string)
    enabled                                = string
    abort_incomplete_multipart_upload_days = string
    expiration_inputs = list(object({
      days = number
    }))
    transition_inputs = list(object({
      days          = number
      storage_class = string
    }))
    noncurrent_version_transition_inputs = list(object({
      days          = number
      storage_class = string
    }))
    noncurrent_version_expiration_inputs = list(object({
      days = number
    }))
  }))
  default = [
    {
      enabled                                = true
      prefix                                 = ""
      abort_incomplete_multipart_upload_days = null
      tags = {
        "rule"      = "log"
        "autoclean" = "true"
      }
      transition_inputs = []
      expiration_inputs = [
        {
          days                         = 3650
          expired_object_delete_marker = false
        }
      ]
      noncurrent_version_transition_inputs = []
      noncurrent_version_expiration_inputs = []
    }
  ]
}

variable "server_side_encryption_configuration_inputs" {
  description = "S3 server side encryption configuration"
  type = list(object({
    sse_algorithm     = string
    kms_master_key_id = string
  }))
  default = null
}

variable "public_access" {
  description = "Set default public access policy for S3 bucket"
  type        = map(string)
  default = {
    block_public_acls       = "true"
    block_public_policy     = "true"
    ignore_public_acls      = "true"
    restrict_public_buckets = "true"
  }
}

