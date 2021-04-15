output "default_key_name" {
  value = aws_key_pair.bosh_vms.key_name
}

output "private_key" {
  value     = tls_private_key.bosh_vms.private_key_pem
  sensitive = true
}

output "external_ip" {
  value = aws_eip.jumpbox_eip.public_ip
}

output "jumpbox_url" {
  value = aws_eip.jumpbox_eip.public_ip
}

output "director_address" {
  value = format("https://%s:25555", aws_eip.jumpbox_eip.public_ip)
}

output "nat_eip" {
  value = aws_eip.nat_eip.public_ip
}

output "internal_security_group" {
  value = aws_security_group.internal_security_group.id
}

output "bosh_security_group" {
  value = aws_security_group.bosh_security_group.id
}

output "jumpbox_security_group" {
  value = aws_security_group.jumpbox.id
}

output "jumpbox__default_security_groups" {
  value = [aws_security_group.jumpbox.id]
}

output "director__default_security_groups" {
  value = [aws_security_group.bosh_security_group.id]
}

output "bosh_subnet_id" {
  value = aws_subnet.bosh_subnet.id
}

output "bosh_subnet_availability_zone" {
  value = aws_subnet.bosh_subnet.availability_zone
}

output "vpc_id" {
  value = local.vpc_id
}

output "region" {
  value = var.region
}

output "kms_key_arn" {
  value = aws_kms_key.kms_key.arn
}

output "internal_az_subnet_id_mapping" {
  value = zipmap(aws_subnet.internal_subnets.*.availability_zone, aws_subnet.internal_subnets.*.id)
}

output "internal_az_subnet_cidr_mapping" {
  value = zipmap(aws_subnet.internal_subnets.*.availability_zone, aws_subnet.internal_subnets.*.cidr_block)
}

output "director_name" {
  value = format("bosh-%s", var.env)
}

output "internal_cidr" {
  value = local.internal_cidr
}

output "internal_gw" {
  value = local.internal_gw
}

output "jumpbox__internal_ip" {
  value = local.jumpbox_internal_ip
}

output "director__internal_ip" {
  value = local.director_internal_ip
}

output "iam_instance_profile" {
  value = local.iamProfileProvided ? join("", data.aws_iam_instance_profile.bosh.*.name) : join("", aws_iam_instance_profile.bosh_iam_instance_profile.*.name)
}