//resource "aws_default_security_group" "default_security_group" {
//  vpc_id = local.vpc_id
//}

### NAT Security Group
resource "aws_security_group" "nat_security_group" {
  name        = join("-", [var.env, "nat-security-group"])
  description = "NAT"
  vpc_id      = local.vpc_id

  tags = {
    Name       = join("-", [var.env, "nat-security-group"])
    Deployment = local.Deployment
  }

  lifecycle {
    ignore_changes = [name]
  }
}

resource "aws_security_group_rule" "nat_to_internet_rule" {
  security_group_id = aws_security_group.nat_security_group.id

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "nat_icmp_rule" {
  security_group_id = aws_security_group.nat_security_group.id

  type        = "ingress"
  protocol    = "icmp"
  from_port   = -1
  to_port     = -1
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "nat_tcp_rule" {
  security_group_id = aws_security_group.nat_security_group.id

  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 0
  to_port                  = 65535
  source_security_group_id = aws_security_group.internal_security_group.id
}

resource "aws_security_group_rule" "nat_udp_rule" {
  security_group_id = aws_security_group.nat_security_group.id

  type                     = "ingress"
  protocol                 = "udp"
  from_port                = 0
  to_port                  = 65535
  source_security_group_id = aws_security_group.internal_security_group.id
}

### Internal Security Group
resource "aws_security_group" "internal_security_group" {
  name        = join("-", [var.env, "internal-security-group"])
  description = "Internal"
  vpc_id      = local.vpc_id

  tags = {
    Name       = join("-", [var.env, "internal-security-group"])
    Deployment = local.Deployment
  }

  lifecycle {
    ignore_changes = [name]
  }
}

resource "aws_security_group_rule" "internal_security_group_rule_tcp" {
  security_group_id = aws_security_group.internal_security_group.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 0
  to_port           = 65535
  self              = true
}

resource "aws_security_group_rule" "internal_security_group_rule_udp" {
  security_group_id = aws_security_group.internal_security_group.id
  type              = "ingress"
  protocol          = "udp"
  from_port         = 0
  to_port           = 65535
  self              = true
}

resource "aws_security_group_rule" "internal_security_group_rule_icmp" {
  security_group_id = aws_security_group.internal_security_group.id
  type              = "ingress"
  protocol          = "icmp"
  from_port         = -1
  to_port           = -1
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "internal_security_group_rule_allow_internet" {
  security_group_id = aws_security_group.internal_security_group.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "internal_security_group_rule_ssh" {
  security_group_id        = aws_security_group.internal_security_group.id
  type                     = "ingress"
  protocol                 = "TCP"
  from_port                = 22
  to_port                  = 22
  source_security_group_id = aws_security_group.jumpbox.id
}

resource "aws_security_group_rule" "bosh_internal_security_rule_tcp" {
  security_group_id        = aws_security_group.internal_security_group.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 0
  to_port                  = 65535
  source_security_group_id = aws_security_group.bosh_security_group.id
}

resource "aws_security_group_rule" "bosh_internal_security_rule_udp" {
  security_group_id        = aws_security_group.internal_security_group.id
  type                     = "ingress"
  protocol                 = "udp"
  from_port                = 0
  to_port                  = 65535
  source_security_group_id = aws_security_group.bosh_security_group.id
}

### BOSH Security Group
resource "aws_security_group" "bosh_security_group" {
  name        = join("-", [var.env, "bosh-security-group"])
  description = "BOSH Director"
  vpc_id      = local.vpc_id

  tags = {
    Name       = join("-", [var.env, "bosh-security-group"])
    Deployment = local.Deployment
  }

  lifecycle {
    ignore_changes = [name, description]
  }
}

resource "aws_security_group_rule" "bosh_security_group_rule_tcp_ssh" {
  security_group_id        = aws_security_group.bosh_security_group.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 22
  to_port                  = 22
  source_security_group_id = aws_security_group.jumpbox.id
}

resource "aws_security_group_rule" "bosh_security_group_rule_tcp_bosh_agent" {
  security_group_id        = aws_security_group.bosh_security_group.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 6868
  to_port                  = 6868
  source_security_group_id = aws_security_group.jumpbox.id
}

resource "aws_security_group_rule" "bosh_security_group_rule_uaa" {
  security_group_id        = aws_security_group.bosh_security_group.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 8443
  to_port                  = 8443
  source_security_group_id = aws_security_group.jumpbox.id
}

resource "aws_security_group_rule" "bosh_security_group_rule_credhub" {
  security_group_id        = aws_security_group.bosh_security_group.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 8844
  to_port                  = 8844
  source_security_group_id = aws_security_group.jumpbox.id
}

resource "aws_security_group_rule" "bosh_security_group_rule_tcp_director_api" {
  security_group_id        = aws_security_group.bosh_security_group.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 25555
  to_port                  = 25555
  source_security_group_id = aws_security_group.jumpbox.id
}

resource "aws_security_group_rule" "bosh_security_group_rule_tcp" {
  security_group_id        = aws_security_group.bosh_security_group.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 0
  to_port                  = 65535
  source_security_group_id = aws_security_group.internal_security_group.id
}

resource "aws_security_group_rule" "bosh_security_group_rule_udp" {
  security_group_id        = aws_security_group.bosh_security_group.id
  type                     = "ingress"
  protocol                 = "udp"
  from_port                = 0
  to_port                  = 65535
  source_security_group_id = aws_security_group.internal_security_group.id
}

resource "aws_security_group_rule" "bosh_security_group_rule_allow_internet" {
  security_group_id = aws_security_group.bosh_security_group.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

### Jumpbox Security Group
resource "aws_security_group" "jumpbox" {
  name        = join("-", [var.env, "jumpbox-security-group"])
  description = "Jumpbox"
  vpc_id      = local.vpc_id

  tags = {
    Name       = join("-", [var.env, "jumpbox-security-group"])
    Deployment = local.Deployment
  }

  lifecycle {
    ignore_changes = [name, description]
  }
}

resource "aws_security_group_rule" "jumpbox_ssh" {
  security_group_id = aws_security_group.jumpbox.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = [var.bosh_inbound_cidr]
}

resource "aws_security_group_rule" "jumpbox_rdp" {
  security_group_id = aws_security_group.jumpbox.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 3389
  to_port           = 3389
  cidr_blocks       = [var.bosh_inbound_cidr]
}

resource "aws_security_group_rule" "jumpbox_agent" {
  security_group_id = aws_security_group.jumpbox.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 6868
  to_port           = 6868
  cidr_blocks       = [var.bosh_inbound_cidr]
}

resource "aws_security_group_rule" "jumpbox_director" {
  security_group_id = aws_security_group.jumpbox.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 25555
  to_port           = 25555
  cidr_blocks       = [var.bosh_inbound_cidr]
}

resource "aws_security_group_rule" "jumpbox_egress" {
  security_group_id = aws_security_group.jumpbox.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}