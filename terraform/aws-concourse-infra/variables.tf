variable "region" {
  description = "Region in use"
  type = "string"
}

variable "bosh_inbound_cidr" {
  default = "0.0.0.0/0"
}

variable "availability_zones" {
  type = "list"
}

variable "env_id" {
  type = "string"
}

variable "short_env_id" {
  type = "string"
}

variable "vpc_cidr" {
  type    = "string"
  default = "10.0.0.0/16"
}