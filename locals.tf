locals {
  my_secret_object = jsondecode(data.aws_secretsmanager_secret_version.leonardo.secret_string)
  secrets_value = "leonardo-secrets"
}