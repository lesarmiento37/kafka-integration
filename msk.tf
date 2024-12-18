

resource "aws_msk_cluster" "leonardo" {
  cluster_name           = "leonardo-cluster"
  kafka_version          = "3.6.0" 
  number_of_broker_nodes = 2

  broker_node_group_info {
    instance_type   = "kafka.t3.small"
    client_subnets  = [
                        replace(jsonencode(local.my_secret_object.SUBNET_1), "\"", ""),
                        replace(jsonencode(local.my_secret_object.SUBNET_2), "\"", ""),
                        #replace(jsonencode(local.my_secret_object.SUBNET_3), "\"", "")
                    ]
    security_groups = [aws_security_group.kafka.id]
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  client_authentication {
    sasl {
      iam = true
    }
    unauthenticated = false
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.leonardo.name
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

#bin/kafka-topics.sh --list --bootstrap-server 54.157.175.115