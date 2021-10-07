Demo producer and consumer Kafka 

## Run programming
- Step 1: enable kafka 
> docker-compose up 
> docker exec -it kafka-cluster_kafka1_1 bash
- Step 2: create topic `hello-kafka`
> kafka-topics --zookeeper zookeeper:2181 --create --topic hello-kafka --partitions 1 --replication-factor 1
- Step 3: Run `SimpleConsumer.java`
- Step 4: Run `SimpleProducer.java`

**With producer**
-  show consumer in terminal
```bash
bin/kafka-console-consumer.sh --topic hello-kafka --bootstrap-server localhost:9092 --from-beginning
```

**With consumer**

- show producer in terminal
```bash
bin/kafka-console-producer.sh --topic hello-kafka --bootstrap-server localhost:9092
``` 
