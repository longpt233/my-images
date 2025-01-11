

# sql
INSERT INTO person (id, name, age) VALUES (121,'John Doe', 30);

# sql
CREATE TABLE person (
    id INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT
);

my_database=# \d person
                      Table "public.person"
 Column |          Type          | Collation | Nullable | Default 
--------+------------------------+-----------+----------+---------
 id     | integer                |           | not null | 
 name   | character varying(100) |           |          | 
 age    | integer                |           |          | 
Indexes:
    "person_pkey" PRIMARY KEY, btree (id)
Publications:
    "dbz_pub"
    "dbz_publication"




CREATE TABLE topic_products (
  ID INT,
  Age INT,
  Name STRING
) WITH (
 'connector' = 'kafka',
 'topic' = 'dbz.public.person',
 'properties.bootstrap.servers' = '10.208.164.167:9092',
 'properties.group.id' = 'connect_configs',
 'format' = 'debezium-json'
);

SELECT * FROM topic_products;

 -- using 'debezium-avro-confluent' as the format to interpret Debezium Avro messages
 'format' = 'debezium-avro-confluent',
 -- the URL to the schema registry for Kafka
 'debezium-avro-confluent.url' = 'http://localhost:8081'


1. lỗi k có connector

 [ERROR] Could not execute SQL statement. Reason:
org.apache.flink.table.api.ValidationException: Could not find any factory for identifier 'kafka' that implements 'org.apache.flink.table.factories.DynamicTableFactory' in the classpath.

Available factory identifiers are:

blackhole
datagen
filesystem
paimon
postgres-cdc
print
python-input-format


-> ./jars/flink-sql-connector-kafka-3.0.0-1.17.jar:/opt/flink/lib/flink-sql-connector-kafka-3.0.0-1.17.jar

2. nỗi k kết nói dc kafka

jobmanager     | 2025-01-11 02:18:42,811 WARN  org.apache.flink.kafka.shaded.org.apache.kafka.clients.NetworkClient [] - [AdminClient clientId=testGroup-enumerator-admin-client] Connection to node 1 (localhost/127.0.0.1:9092) could not be established. Broker may not be available.


KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:29092,PLAINTEXT_HOST://localhost:9092
từ ngoài vào: 
-> KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:29092,PLAINTEXT_HOST://10.208.164.167:9092

3. lỗi partition offset 

[ERROR] Could not execute SQL statement. Reason:
org.apache.flink.kafka.shaded.org.apache.kafka.clients.consumer.NoOffsetForPartitionException: Undefined offset with no reset policy for partitions: [dbz.public.person-0]


>  'properties.group.id' = 'testGroup1',
-> >  'properties.group.id' = 'connect_configs',

đéo hiểu cái group id này ở đâu ra

4. Corrupt Debezium JSON message

Flink SQL> SELECT * FROM topic_products;
[ERROR] Could not execute SQL statement. Reason:
java.lang.NullPointerException

log client: 
root@bcf9a56e5604:/opt/flink# cat log/flink--sql-client-bcf9a56e5604.log
Caused by: java.io.IOException: Failed to deserialize consumer record ConsumerRecord(
Caused by: java.io.IOException: Corrupt Debezium JSON message '{"schema":{"   ....


In order to interpret such messages, you need to add the option 'debezium-json.schema-include' = 'true' into above DDL WITH clause (false by default). 
Usually, this is not recommended to include schema because this makes the messages very verbose and reduces parsing performance.

ref: https://nightlies.apache.org/flink/flink-docs-master/docs/connectors/table/formats/debezium/

-> 'debezium-json.schema-include' = 'true'

CREATE TABLE topic_products (
  ID INT,
  Age INT,
  Name STRING
) WITH (
 'connector' = 'kafka',
 'topic' = 'dbz.public.person',
 'properties.bootstrap.servers' = '10.208.164.167:9092',
 'properties.group.id' = 'connect_configs',
 'format' = 'debezium-json',
 'debezium-json.schema-include' = 'true'
);

-> bị null hết 
2025-01-11 02:36:13,130 INFO  org.apache.flink.client.program.rest.RestClusterClient       [] - Submitting job 'SELECT `topic_products`.`ID`, `topic_products`.`Age`, `topic_products`.`Name`
FROM `default_catalog`.`default_database`.`topic_products` AS `topic_products`' (99b89429ab64f5586ba26aef2d4ff9d7).
2025-01-11 02:36:13,188 INFO  org.apache.flink.client.program.rest.RestClusterClient       [] - Successfully submitted job 'SELECT `topic_products`.`ID`, `topic_products`.`Age`, `topic_products`.`Name`

my_database=# \d+ person
                                                 Table "public.person"
 Column |          Type          | Collation | Nullable | Default | Storage  | Compression | Stats target | Description 
--------+------------------------+-----------+----------+---------+----------+-------------+--------------+-------------
 id     | integer                |           | not null |         | plain    |             |              | 
 name   | character varying(100) |           |          |         | extended |             |              | 
 age    | integer                |           |          |         | plain    |             |              | 
Indexes:
    "person_pkey" PRIMARY KEY, btree (id)
Publications:
    "dbz_pub"
    "dbz_publication"
Access method: heap



CREATE TABLE topic_products (
  id INT,
  age INT,
  name STRING
) WITH (
 'connector' = 'kafka',
 'topic' = 'dbz.public.person',
 'properties.bootstrap.servers' = '10.208.164.167:9092',
 'properties.group.id' = 'connect_configs',
 'format' = 'debezium-json',
 'debezium-json.schema-include' = 'true'
);


select * from topic_products;
my_database=# INSERT INTO person (id, name, age) VALUES (12771,'John Doe', 30);
INSERT 0 1

 Refresh: 5 s    Page: Last of 1   Updated: 02:42:17.060 

          id         age                           name
       12771          30                       John Doe



