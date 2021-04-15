resource "aws_vpc" "vpc" {
  count                = local.vpc_count
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name       = format("%s-%s-vpc", var.region, var.env)
    Deployment = local.Deployment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id
}

resource "aws_eip" "jumpbox_eip" {
  depends_on = [aws_internet_gateway.igw]
  vpc        = true
}

resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.bosh_subnet.id
  allocation_id = aws_eip.nat_eip.id

  tags = {
    Name       = join("-", [var.env, "nat"])
    EnvID      = var.env
    Deployment = local.Deployment
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Name       = join("-", [var.env, "nat"])
    EnvID      = var.env
    Deployment = local.Deployment
  }
}

resource "aws_subnet" "bosh_subnet" {
  vpc_id     = local.vpc_id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, 0)

  tags = {
    Name       = join("-", [var.env, "bosh-subnet"])
    Deployment = local.Deployment
  }
}

resource "aws_route_table" "bosh_route_table" {
  vpc_id = local.vpc_id
}

resource "aws_route" "bosh_route_table" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  route_table_id         = aws_route_table.bosh_route_table.id
}

resource "aws_route_table_association" "route_bosh_subnets" {
  subnet_id      = aws_subnet.bosh_subnet.id
  route_table_id = aws_route_table.bosh_route_table.id
}

resource "aws_subnet" "internal_subnets" {
  count             = length(var.availability_zones)
  vpc_id            = local.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + 1)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name       = format("%s-internal-subnet%d", var.env, count.index)
    Deployment = local.Deployment
  }

  lifecycle {
    ignore_changes = [cidr_block, availability_zone]
  }
}

resource "aws_route_table" "nated_route_table" {
  vpc_id = local.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "route_internal_subnets" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.internal_subnets.*.id, count.index)
  route_table_id = aws_route_table.nated_route_table.id
}

resource "aws_flow_log" "vpc_flow_log" {
  iam_role_arn    = aws_iam_role.flow_logs_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_flog_log_cw_group.arn
  traffic_type    = "REJECT"
  vpc_id          = local.vpc_id
}

resource "aws_cloudwatch_log_group" "vpc_flog_log_cw_group" {
  name_prefix = join("-", [var.env, "log-group"])
}
