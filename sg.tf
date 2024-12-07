resource "aws_security_group" "kafka" {
  name_prefix = "leonardo-kafka-sg"
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = [replace(jsonencode(local.my_secret_object.LEONARDO_IP), "\"", ""),replace(jsonencode(local.my_secret_object.VPC_CIDR), "\"", "")]
  }
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self      = "true"
  }

  tags = {
    Environment = "leonardo"
  }
  
}