#resource "aws_opensearch_domain" "leonardo" {
  #domain_name           = "leonardo-domain" 
  #engine_version        = "OpenSearch_2.5" 
#
  ## Enable public access
  #access_policies = <<EOT
#{
  #"Version": "2012-10-17",
  #"Statement": [
    #{
      #"Effect": "Allow",
      #"Principal": "*",
      #"Action": "es:*",
      #"Resource": "*"
    #}
  #]
#}
#EOT
#
  #cluster_config {
    #instance_type = "t3.small.search" 
    #instance_count = 1             
  #}
#
  #ebs_options {
    #ebs_enabled = true
    #volume_size = 20
    #volume_type = "gp2"
  #}
#
  #node_to_node_encryption {
    #enabled = true
  #}
#
  #encrypt_at_rest {
    #enabled = true
  #}
#
  #domain_endpoint_options {
    #enforce_https       = true
    #tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  #}
#
  #advanced_security_options {
    #enabled                        = true
    #anonymous_auth_enabled         = false
    #internal_user_database_enabled = true
    #master_user_options {
      #master_user_name     = replace(jsonencode(local.my_secret_object.OPENSEARCH_USER), "\"", "")
      #master_user_password = replace(jsonencode(local.my_secret_object.OPENSEARCH_PASSWORD), "\"", "")
    #}
  #}
#
  #tags = {
    #Environment = "dev"
    #Project     = "leonardo-project"
  #}
#}
#
#output "opensearch_endpoint" {
  #description = "The endpoint of the OpenSearch domain"
  #value       = aws_opensearch_domain.leonardo.endpoint
#}
