

resource "aws_msk_cluster" "leonardo" {
  cluster_name           = "leonardo-cluster"
  kafka_version          = "3.6.0" 
  number_of_broker_nodes = 1

  broker_node_group_info {
    instance_type   = "kafka.t3.small"
    client_subnets  = ["subnet-0758fd9a205ea1af5"]
    security_groups = ["sg-12345678"]
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = "msk-log-group" # Replace with your CloudWatch log group name
      }
    }
  }
}

output "zookeeper_connect_string" {
  description = "The Zookeeper connection string"
  value       = aws_msk_cluster.leonardo.zookeeper_connect_string
}

output "zookeeper_connect_string_tls" {
  description = "The Zookeeper connection string with TLS"
  value       = aws_msk_cluster.leonardo.zookeeper_connect_string_tls
}
