resource "aws_cloudwatch_log_group" "leonardo" {
  name              = "msk-log-group" 
  retention_in_days = 7 

  tags = {
    Environment = "dev"
    Team        = "Leonardo"
  }
}