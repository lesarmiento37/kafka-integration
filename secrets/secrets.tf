
resource "aws_kms_key" "terraform_key" {
  description = "Terraform KMS key"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "terraform_alias" {
  name          = "alias/leonardo-secrets-manager-kms"
  target_key_id = aws_kms_key.terraform_key.key_id
}

resource "aws_secretsmanager_secret" "terraform" {
  name = "leonardo-secrets"
}

resource "aws_secretsmanager_secret_version" "terraform_secrets" {
  secret_id = aws_secretsmanager_secret.terraform.id
  secret_string = jsonencode(local.secrets)
  #kms_key_id = aws_kms_key.terraform_key.arn
}
resource "aws_ssm_parameter" "secrets_version" {
  name  = "/LEONARDO_SECRETS_VERSION"
  type  = "String"
  value = aws_secretsmanager_secret.terraform.arn
}