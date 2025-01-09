#!/bin/bash
#./bin/kafka-console-producer.sh --topic leonardo-topic --producer.config config/client.properties --bootstrap-server b-2.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9098,b-1.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9098

#export KAFKA_OPTS="-Djava.security.auth.login.config=/home/leonardo/kafka_2.13-3.9.0/config/kafka_client_jaas.conf"
#export KAFKA_OPTS="-Djava.security.auth.login.config=/home/ec2-user/SageMakerkafka_client_jaas.conf"

keytool -import -trustcacerts -alias rootCA \
-file /home/leonardo/kafka_2.13-3.9.0/config/AmazonRootCA1.pem \
-keystore /home/leonardo/kafka_2.13-3.9.0/config/kafka.truststore.p12 \
-storetype PKCS12 \
-noprompt \
-storepass leonardo

#./bin/kafka-topics.sh --create  --topic leonardo-topic --command-config config/client.properties --bootstrap-server b-1-public.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9198,b-2-public.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9198
#./bin/kafka-topics.sh \
    --bootstrap-server b-1-public.leonardocluster.ykfidp.c14.kafka.us-east-1.amazonaws.com:9198,b-2-public.leonardocluster.ykfidp.c14.kafka.us-east-1.amazonaws.com:9198 \
    --command-config config/client.properties \
    --list

./bin/kafka-console-consumer.sh \
    --bootstrap-server b-1-public.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9198,b-2-public.leonardocluster.5irmip.c20.kafka.us-east-1.amazonaws.com:9198 \
    --consumer.config config/client.properties \
    --topic pastor-lopez-loquito \
    --from-beginning

./bin/kafka-topics.sh \
    --bootstrap-server b-2-public.leonardocluster.ykfidp.c14.kafka.us-east-1.amazonaws.com:9198,b-1-public.leonardocluster.ykfidp.c14.kafka.us-east-1.amazonaws.com:9198 \
    --command-config config/client.properties \
    --topic pokemon-gen-1-topic \
    --describe

./bin/kafka-consumer-groups.sh \
    --bootstrap-server b-2-public.leonardocluster.ykfidp.c14.kafka.us-east-1.amazonaws.com:9198,b-1-public.leonardocluster.ykfidp.c14.kafka.us-east-1.amazonaws.com:9198 \
    --command-config config/client.properties \
    --list

./bin/kafka-consumer-groups.sh \
    --bootstrap-server b-2-public.leonardocluster.ykfidp.c14.kafka.us-east-1.amazonaws.com:9198,b-1-public.leonardocluster.ykfidp.c14.kafka.us-east-1.amazonaws.com:9198 \
    --command-config config/client.properties \
    --all-groups \
    --describe

./bin/kafka-console-consumer.sh \
    --bootstrap-server b-2-public.leonardocluster.ykfidp.c14.kafka.us-east-1.amazonaws.com:9198,b-1-public.leonardocluster.ykfidp.c14.kafka.us-east-1.amazonaws.com:9198 \
    --consumer.config config/client.properties \
    --topic pokemon-gen-2-topic \
    --group pokemon-gen-2-group \
    --from-beginning

