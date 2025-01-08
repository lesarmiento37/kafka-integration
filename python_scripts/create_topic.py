
from kafka.errors import KafkaError
from kafka.admin import KafkaAdminClient, NewTopic
import socket
import time
from aws_msk_iam_sasl_signer import MSKAuthTokenProvider
import boto3
import json

region = "us-east-1"

class MSKTokenProvider():
    def token(self):
        token, _ = MSKAuthTokenProvider.generate_auth_token(region)
        return token

tp = MSKTokenProvider()


# Kafka configuration using IAM SASL Signer based on the official AWS documentation
#config = {
    #"bootstrap.servers": "b-2-public.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9198,b-1-public.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9198",
    #"security.protocol": "SASL_SSL",
    #"sasl.mechanism": "OAUTHBEARER",
    #"ssl.ca.location": "AmazonRootCA1.pem",
    #"sasl.client.callback.handler.class": "aws_msk_iam_sasl_signer.MSKAuth"
#}

# Initialize Kafka Admin Client
#admin_client = KafkaAdminClient(config)

admin_client = KafkaAdminClient(
    bootstrap_servers="b-2-public.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9198,b-1-public.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9198",
    security_protocol="SASL_SSL",
    sasl_mechanism="OAUTHBEARER",
    sasl_oauth_token_provider=tp,
    client_id=socket.gethostname(),
)

def create_topic(topic_name, num_partitions, replication_factor):
    """Create a Kafka topic using MSK IAM authentication."""
    topic = NewTopic(name=topic_name, num_partitions=num_partitions, replication_factor=replication_factor)
    #response = admin_client.create_topics([topic])
    #print(response)
    try:
        response = admin_client.create_topics([topic])
        # Fix: Correctly accessing the tuple structure
        for topic_error in response.topic_errors:
            topic_name, error_code, error_message = topic_error
            if error_code == 0:
                print(f"Topic '{topic_name}' successfully created.")
            else:
                print(f"Error creating topic '{topic_name}': {error_message}")
    except KafkaError as e:
        print(f"KafkaError occurred: {e}")
    except Exception as e:
        print(f"Failed to create topic '{topic_name}': {e}")
    finally:
        print("Topic creation attempt complete.")
# Create the topic
if __name__ == "__main__":
    create_topic("pastor-lopez-loquito",3,2)



