
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

output "id" {
  value = aws_s3_bucket.b.id
}
output "arn" {
  value = aws_s3_bucket.b.arn
}
output "bucket_domain_name" {
  value = aws_s3_bucket.b.bucket_domain_name
}
output "bucket_regional_domain_name" {
  value = aws_s3_bucket.b.bucket_regional_domain_name
}
output "hosted_zone_id" {
  value = aws_s3_bucket.b.hosted_zone_id
}
output "region" {
  value = aws_s3_bucket.b.region
}
output "website_endpoint" {
  value = aws_s3_bucket.b.website_endpoint
}
output "website_domain" {
  value = aws_s3_bucket.b.website_domain
}

