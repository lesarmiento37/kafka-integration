terraform {
  backend "s3" {
    bucket         = "leonardo-devops-days-staging"
    key            = "secrets/secrets.tfstate"
    region         = "us-east-1"
    dynamodb_table = "leonardo-tf-locks"
    encrypt        = true
  }
}