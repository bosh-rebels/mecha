variable "env" {
  description = "Name of the environment in use"
  type        = string
  default     = "genesis"
}

variable "deployment" {
  description = "The way the resource is deployed"
  type        = string
  default     = "Terraform"
}

variable "region" {
  description = "Region in use"
  type        = string
  default     = "eu-west-1"
}

variable "s3_state_bucket_name" {
  description = "TF State bucket name"
  type        = string
  default     = "tf-state-bucket"
}

variable "s3_state_bucket_description" {
  description = "What is this bucket used for"
  type        = string
  default     = "Bucket used to store TF state"
}

variable "s3_state_bucket_acl" {
  description = "Bucket Access Control List"
  type        = string
  default     = "private"
}

variable "state_user_name" {
  description = "User name which will have access to control the environment in use"
  type        = string
  default     = "genesis-eu-west-1-tf-state-user"
}

variable "iam_user_policy_name" {
  description = "Name of the policy which will be applied to the user who will control the state"
  type = string
  default = "genesis-eu-west-1-tf-state-user-policy"
}

