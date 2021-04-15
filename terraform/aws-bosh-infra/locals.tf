locals {

  vpc_count = length(var.existing_vpc_id) > 0 ? 0 : 1
  vpc_id    = length(var.existing_vpc_id) > 0 ? var.existing_vpc_id : join(" ", aws_vpc.vpc.*.id)

  internal_cidr        = aws_subnet.bosh_subnet.cidr_block
  internal_gw          = cidrhost(local.internal_cidr, 1)
  jumpbox_internal_ip  = cidrhost(local.internal_cidr, 5)
  director_internal_ip = cidrhost(local.internal_cidr, 6)
  iamProfileProvided   = var.bosh_iam_instance_profile == "" ? 0 : 1
  Deployment           = "Terraform"
}
