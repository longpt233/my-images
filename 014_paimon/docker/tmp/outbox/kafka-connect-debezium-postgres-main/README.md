# Kafka Connect: Debezium, Postgres and Spring Boot Demo

Spring Boot application demonstrating the Transactional Outbox pattern using Debezium (Kafka Connect) for Change Data Capture (CDC) to publish outbound events to Kafka from Postgres.

This repo accompanies the article [Kafka Connect: Transactional Outbox With Debezium: Spring Boot Demo](https://www.lydtechconsulting.com/blog-kafka-connect-debezium-demo.html).

## Running The Demo

The demo steps are as follows (and detailed below):
- Start the Docker containers (Kafka, Zookeeper, Postgres, Debezium) via docker-compose.
- Submit the Kafka Connect connector definition via curl.
- Start the Spring Boot demo application.
- Start a console-consumer to listen on the outbox topic (populated by Debezium).
- Submit a REST request to the application to create an item
- The application creates the item entity and writes to the outbox table.  Debezium writes an event to the outbound topic via Change Data Capture (CDC).  The console-consumer consumes this event.

Demo steps breakdown:

Build Spring Boot application with Java 17:
```
mvn clean install
```

Start Docker containers:
```
docker-compose up -d
```

Check status of Kafka Connect:
```
curl localhost:8083
```

List registered connectors (empty array initially):
```
curl localhost:8083/connectors
```

Register connector:
```
curl -X POST localhost:8083/connectors -H "Content-Type: application/json" -d @./connector/debezium-postgres-source-connector.json
```

List registered connectors:
```
curl localhost:8083/connectors
["debezium-postgres-source-connector"]
```

Start Spring Boot application:
```
java -jar target/kafka-connect-debezium-postgres-demo-1.0.0.jar
```

Jump onto Kafka docker container:
```
docker exec -ti kafka bash
```

Start console-consumer to listen for outbox event:
```
kafka-console-consumer --topic outbox.event.item --bootstrap-server kafka:29092
```

In a second terminal window use curl to submit a POST REST request to the application to create an item:
```
curl -i -X POST localhost:9001/v1/item -H "Content-Type: application/json" -d '{"name": "test-item"}'
```

A response should be returned with the 201 CREATED status code and the new item id in the Location header:
```
HTTP/1.1 201 
Location: 3e97d918-85cf-47ce-b58f-e13be187f080
```

The Spring Boot application should log the successful item and outbox entities persistence:
```
Item created with id 3e97d918-85cf-47ce-b58f-e13be187f080 - and Outbox entity created with Id: 687e5def-2c87-4d5b-ade1-27f8b4ed41b1
```

View outbox event consumed by the console-consumer from Kafka:
```
{"schema":{"type":"string","optional":true},"payload":"{\"id\":\"3e97d918-85cf-47ce-b58f-e13be187f080\",\"name\":\"test-item\"}"}
```

Delete registered connector:
```
curl -i -X DELETE localhost:8083/connectors/debezium-postgres-source-connector
```

Stop containers:
```
docker-compose down
```

## Integration Tests

Build and test with maven and Java 17.

Run integration tests with `mvn clean test`

The tests demonstrate the application receiving the REST request to create an item, and succesfully creating the Item entity and Outbox entity.

## Component Tests

The tests demonstrate the application publishing events using the Transactional Outbox pattern using Debezium (Kafka Connect) for Change Data Capture.   They use a dockerised Kafka broker, a dockerised Debezium Kafka Connect, a dockerised Postgres database, and a dockerised instance of the application.

To test the application running against the Apache Kafka native instance, set `kafka.enabled` to `false` and `kafka.native.enabled` to `true` in the `pom.xml`.

For more on the component tests see: https://github.com/lydtechconsulting/component-test-framework

Build Spring Boot application jar:
```
mvn clean install
```

Build Docker container:
```
docker build -t ct/kafka-connect-debezium-postgres-demo:latest .
```

Run tests:
```
mvn test -Pcomponent
```

Run tests leaving containers up:
```
mvn test -Pcomponent -Dcontainers.stayup
```

Manual clean up (if left containers up):
```
docker rm -f $(docker ps -aq)
```

## Kafka Connect / Debezium

### Create Postgres connector

The Debezium Postgres source connector configuration is defined in `connector/debezium-postgres-source-connector.json`.

It includes a Single Message Transform (SMT) that routes the outbox event to the value of the payload field in the outbox event database table.

The component tests create and delete the connector via the `DebeziumClient` class in the `component-test-framework`.

## Docker Clean Up

Manual clean up (if left containers up):
```
docker rm -f $(docker ps -aq)
```

Further docker clean up if network/other issues:
```
docker system prune
docker volume prune
```
