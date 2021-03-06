variable "region" {
  description = "Region in use"
  type        = string
}

variable "bosh_inbound_cidr" {
  default = "0.0.0.0/0"
}

variable "availability_zones" {
  type = list(string)
}

variable "env" {
  type    = string
  default = "genesis"
}

variable "existing_vpc_id" {
  description = "Provide existing VPC id ready to go"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "bosh_iam_instance_profile" {
  default = ""
}
