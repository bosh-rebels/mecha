resource "aws_iam_role" "flow_logs_role" {
  name = format("%s-flow-logs-role", var.env)

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "flow_logs_role_policy" {
  name = format("%s-flow-logs-policy", var.env)
  role = aws_iam_role.flow_logs_role.id

  policy = data.template_file.flog_logs_role_policy.rendered
}

resource "aws_iam_role" "bosh_iam_role" {
  count = 1 - local.iamProfileProvided

  name = format("%s_bosh_role", var.env)
  path = "/"

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "bosh_iam_role_policy" {
  count = 1 - local.iamProfileProvided

  name   = format("%s_bosh_policy", var.env)
  path   = "/"
  policy = data.template_file.bosh_iam_role_policy.rendered
}

resource "aws_iam_role_policy_attachment" "bosh_iam_role_policy_attachment" {
  count = 1 - local.iamProfileProvided

  role       = format("%s_bosh_role", var.env)
  policy_arn = aws_iam_policy.bosh_iam_role_policy[count.index].arn
}

resource "aws_iam_instance_profile" "bosh_iam_instance_profile" {
  count = 1 - local.iamProfileProvided

  name = format("%s-bosh", var.env)
  role = aws_iam_role.bosh_iam_role[count.index].name

  lifecycle {
    ignore_changes = [name]
  }
}