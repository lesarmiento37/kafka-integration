data "aws_secretsmanager_secret_version" "leonardo" {
  secret_id =local.secrets_value
}