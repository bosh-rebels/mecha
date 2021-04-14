locals {
  internal_cidr        = aws_subnet.bosh_subnet.cidr_block
  internal_gw          = cidrhost(local.internal_cidr, 1)
  jumpbox_internal_ip  = cidrhost(local.internal_cidr, 5)
  director_internal_ip = cidrhost(local.internal_cidr, 6)
  iamProfileProvided   = var.bosh_iam_instance_profile == "" ? 0 : 1
  Deployment           = "Terraform"
}