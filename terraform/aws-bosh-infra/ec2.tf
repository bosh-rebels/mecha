resource "tls_private_key" "bosh_vms" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bosh_vms" {
  key_name   = join("_", [var.env, "bosh_vms"])
  public_key = tls_private_key.bosh_vms.public_key_openssh
}
