from kafka import KafkaProducer
from aws_msk_iam_sasl_signer import MSKAuthTokenProvider
import json
import socket

region = "us-east-1"

# Token provider for AWS MSK IAM authentication
class MSKTokenProvider:
    def token(self):
        token, _ = MSKAuthTokenProvider.generate_auth_token(region)
        return token

# Initialize the token provider
token_provider = MSKTokenProvider()

# Initialize Kafka Producer with IAM authentication
producer = KafkaProducer(
    bootstrap_servers=[
        "b-2-public.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9198",
        "b-1-public.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9198"
    ],
    security_protocol="SASL_SSL",
    sasl_mechanism="OAUTHBEARER",
    sasl_oauth_token_provider=token_provider,
    value_serializer=lambda v: json.dumps(v).encode('utf-8'),
    client_id=socket.gethostname()
)

def send_message(topic_name, message):
    """Send a message to the specified Kafka topic."""
    try:
        future = producer.send(topic_name, value=message)
        record_metadata = future.get(timeout=10)
        print(f"Message sent to {record_metadata.topic} partition {record_metadata.partition} offset {record_metadata.offset}")
    except Exception as e:
        print(f"Failed to send message: {e}")

# Example usage
if __name__ == "__main__":
    send_message("pastor-lopez-quiere", {"event": "Hello Leonardo!", "type": "greeting"})
    producer.close()
