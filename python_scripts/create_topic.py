def create_topic(bootstrap_servers,topic_name,num_partitions,replication_factor):
    # Create Kafka Admin Client
    admin_client = KafkaAdminClient(
        bootstrap_servers=bootstrap_servers,
        client_id="python_kafka_client"
    )

    # Define a new topic
    new_topic = NewTopic(
        name=topic_name,
        num_partitions=num_partitions,
        replication_factor=replication_factor
    )

    try:
        # Create the topic
        admin_client.create_topics(new_topics=[new_topic], validate_only=False)
        print(f"Topic '{topic_name}' created successfully!")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        admin_client.close()

