
variable "bucket_name" {}
variable "environment" {}

resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

resource "aws_iam_user" "u" {
  name = "${var.bucket_name}-user"
  path = "/system/"

  tags = {
    Name        = "${var.bucket_name} bucket user"
    Environment = var.environment
  }
}

resource "aws_iam_access_key" "u" {
  user = aws_iam_user.u.name
}

resource "aws_iam_user_policy" "b_u" {
  name = "test"
  user = aws_iam_user.u.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
          "${aws_s3_bucket.b.arn}",
          "${aws_s3_bucket.b.arn}*"
      ]
    }
  ]
}
EOF

}

output "bucket_id" {
  value = aws_s3_bucket.b.id
}
output "bucket_arn" {
  value = aws_s3_bucket.b.arn
}
output "bucket_bucket_domain_name" {
  value = aws_s3_bucket.b.bucket_domain_name
}
output "bucket_bucket_regional_domain_name" {
  value = aws_s3_bucket.b.bucket_regional_domain_name
}
output "bucket_hosted_zone_id" {
  value = aws_s3_bucket.b.hosted_zone_id
}
output "bucket_region" {
  value = aws_s3_bucket.b.region
}
output "bucket_website_endpoint" {
  value = aws_s3_bucket.b.website_endpoint
}
output "bucket_website_domain" {
  value = aws_s3_bucket.b.website_domain
}

output "iam_id" {
  value = aws_iam_access_key.u.id
}
output "iam_user" {
  value = aws_iam_access_key.u.user
}
output "iam_secret" {
  value = aws_iam_access_key.u.secret
}
