Demo producer and consumer Kafka 

## Run programming
- Step 1: enable kafka
- Step 2: create topic `hello-kafka`

**With producer**
- Step 3: create consumer in terminal
```bash
bin/kafka-console-consumer.sh --topic hello-kafka --bootstrap-server localhost:9092 --from-beginning
```
- Step 4: Run `SimpleProducer.java`

**With consumer**
- Step 3: Run `SimpleConsumer.java`
- Step 4: create producer in terminal
```bash
bin/kafka-console-producer.sh --topic hello-kafka --bootstrap-server localhost:9092
``` 
