from kafka import KafkaConsumer
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

# Initialize Kafka Consumer with IAM authentication
consumer = KafkaConsumer(
    "pastor-lopez-quiere",
    bootstrap_servers=[
        "b-2-public.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9198",
        "b-1-public.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9198"
    ],
    security_protocol="SASL_SSL",
    sasl_mechanism="OAUTHBEARER",
    sasl_oauth_token_provider=token_provider,
    value_deserializer=lambda v: json.loads(v.decode('utf-8')),
    group_id="pastor-lopez-group",
    client_id=socket.gethostname(),
    auto_offset_reset="earliest"
)

# Consume messages from the Kafka topic
def consume_messages():
    try:
        print("Starting consumer...")
        for message in consumer:
            print(f"Received message: {message.value} from topic {message.topic} partition {message.partition} offset {message.offset}")
    except Exception as e:
        print(f"Error while consuming messages: {e}")
    finally:
        consumer.close()

if __name__ == "__main__":
    consume_messages()
