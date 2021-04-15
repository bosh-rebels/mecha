output "iam_user" {
  value = aws_iam_access_key.iam_user_access_key.user
}

output "iam_access_key_id" {
  value = aws_iam_access_key.iam_user_access_key.id
}

output "iam_access_key_secret_id" {
  value = aws_iam_access_key.iam_user_access_key.secret
}
