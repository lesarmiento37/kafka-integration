locals {
  secrets = data.sops_file.secrets.data
  source_file = "secrets.yaml"
}
