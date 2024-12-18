def produce_tuning_acks(bootstrap_servers,topic_name,num_records,record_size,acks):
    # Create a producer with acks=0
    producer = KafkaProducer(
        bootstrap_servers=bootstrap_servers,
        acks=acks,  # Set acks=0
        value_serializer=lambda v: v.encode('utf-8')  # Serialize to UTF-8
    )
    
    # Generate a message of the specified size
    message = "A" * record_size  # Example message with 'A' repeated
    
    # Measure performance
    start_time = time.time()
    for i in range(num_records):
        producer.send(topic_name, value=message)
        if i % 1000 == 0:
            print(f"Produced {i} records...")  # Log progress
    
    producer.flush()
    end_time = time.time()
    
    # Calculate performance metrics
    elapsed_time = end_time - start_time
    throughput = num_records / elapsed_time
    print("-----------------RESULTS-----------------")
    results = {
        "acks": acks,
        "records_produced": num_records,
        "record_size": record_size,
        "elapsed_time_sec": elapsed_time,
        "throughput_records_per_sec": throughput
    }
    print(results)
    print("------------------------------------------")
