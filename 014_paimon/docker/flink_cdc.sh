
https://nightlies.apache.org/flink/flink-cdc-docs-release-3.2/docs/connectors/flink-sources/postgres-cdc/

https://github.com/gordonmurray/apache_flink_paimon_and_seatunnel/blob/main/jobs/job.sql


CREATE TABLE topic_products (
  -- schema is totally the same to the MySQL "products" table
  id BIGINT,
  name STRING,
  description STRING,
  weight DECIMAL(10, 2)
) WITH (
 'connector' = 'kafka',
 'topic' = 'products_binlog',
 'properties.bootstrap.servers' = 'localhost:9092',
 'properties.group.id' = 'testGroup',
 -- using 'debezium-json' as the format to interpret Debezium JSON messages
 'format' = 'debezium-json'
)


./bin/sql-client.sh 



CREATE CATALOG paimon_catalog WITH (
    'type' = 'paimon',
    'warehouse' = 's3://paimon/warehouse',
    's3.endpoint' = 'http://10.208.164.167:9000',
    's3.access-key' = 'minio',  
    's3.secret-key' = 'minio123',
    's3.path.style.access' = 'true',
    'location-in-properties' = 'true'
);


CREATE CATALOG paimon_catalog_hdfs WITH (
    'type' = 'paimon',
    'warehouse' = 'hdfs://10.208.164.172:9000/test11'
);


use catalog paimon_catalog;
show databases;
create database test_db;
use test_db;


# bang goc
CREATE TABLE person (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT
);


CREATE TABLE person (
  ID INT,
  Age INT,
  Name STRING
  PRIMARY KEY (id) NOT ENFORCED
) WITH (
  'connector' = 'postgres-cdc',
  'hostname' = '10.208.164.167',
  'port' = '5431',
  'username' = 'data_etl',
  'password' = 'data_etl',
  'database-name' = 'my_database',
  'schema-name' = 'public',
  'table-name' = 'person',
  'slot.name' = 'flink',
  'scan.incremental.snapshot.enabled' = 'true'
);

[ERROR] Could not execute SQL statement. Reason:
org.apache.flink.table.catalog.exceptions.CatalogException: Paimon Catalog only supports paimon tables, but you specify  'connector'= 'postgres-cdc' when using Paimon Catalog
 You can create TEMPORARY table instead if you want to create the table of other connector.


-> temporary

CREATE temporary TABLE person1 (
  ID INT,
  Age INT,
  Name STRING,
  PRIMARY KEY (ID) NOT ENFORCED
) WITH (
  'connector' = 'postgres-cdc',
  'hostname' = '10.208.164.167',
  'port' = '5431',
  'username' = 'data_etl',
  'password' = 'data_etl',
  'database-name' = 'my_database',
  'schema-name' = 'public',
  'table-name' = 'person',
  'slot.name' = 'flink',
  'decoding.plugin.name'= 'pgoutput'
);



# -> không ghi ra s3 : kiểm tra checkpoint https://github.com/apache/paimon/issues/2263

SET 'execution.checkpointing.interval' = '1 s';

  'scan.incremental.snapshot.enabled' = 'true'
   -- experimental feature: incremental snapshot (default off)

select * from person;


CREATE TABLE myproducts (
    id INT PRIMARY KEY NOT ENFORCED,
        Age INT,
    name VARCHAR
);

INSERT INTO myproducts (id,Age, name) SELECT ID, Age, Name FROM person;

1. lỗi unexpected block data

org.apache.flink.streaming.runtime.tasks.StreamTaskException: Cannot instantiate user function.
	at org.apache.flink.streaming.api.graph.StreamConfig.getStreamOperatorFactory(StreamConfig.java:416) ~[flink-dist-1.20.0.jar:1.20.0]
	at org.apache.flink.streaming.runtime.tasks.OperatorChain.<init>(OperatorChain.java:169) ~[flink-dist-1.20.0.jar:1.20.0]
	at org.apache.flink.streaming.runtime.tasks.RegularOperatorChain.<init>(RegularOperatorChain.java:60) ~[flink-dist-1.20.0.jar:1.20.0]
	at org.apache.flink.streaming.runtime.tasks.StreamTask.restoreInternal(StreamTask.java:789) ~[flink-dist-1.20.0.jar:1.20.0]
	at org.apache.flink.streaming.runtime.tasks.StreamTask.restore(StreamTask.java:771) ~[flink-dist-1.20.0.jar:1.20.0]
	at org.apache.flink.runtime.taskmanager.Task.runWithSystemExitMonitoring(Task.java:970) ~[flink-dist-1.20.0.jar:1.20.0]
	at org.apache.flink.runtime.taskmanager.Task.restoreAndInvoke(Task.java:939) ~[flink-dist-1.20.0.jar:1.20.0]
	at org.apache.flink.runtime.taskmanager.Task.doRun(Task.java:763) ~[flink-dist-1.20.0.jar:1.20.0]
	at org.apache.flink.runtime.taskmanager.Task.run(Task.java:575) ~[flink-dist-1.20.0.jar:1.20.0]
	at java.lang.Thread.run(Unknown Source) ~[?:?]
Caused by: java.io.StreamCorruptedException: unexpected block data

 -> phải rs cụm éo hiểu https://nightlies.apache.org/flink/flink-cdc-docs-release-3.2/docs/connectors/flink-sources/overview/
mình add cái lib flink-sql-connector-postgres-cdc-3.2.1.jar vào sau chạy bị lỗi trên lol 

    Setup a Flink cluster with version 1.12+ and Java 8+ installed.
    Download the connector SQL jars from the Downloads page (or build yourself).
    Put the downloaded jars under FLINK_HOME/lib/.
    Restart the Flink cluster.



2. decoderbufs

2025-01-10 20:46:40
io.debezium.DebeziumException: Creation of replication slot failed
	at io.debezium.connector.postgresql.PostgresConnectorTask.start(PostgresConnectorTask.java:144)
	at io.debezium.connector.common.BaseSourceTask.start(BaseSourceTask.java:133)
	at io.debezium.embedded.EmbeddedEngine.run(EmbeddedEngine.java:760)
	at io.debezium.embedded.ConvertingEngineBuilder$2.run(ConvertingEngineBuilder.java:192)
	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(Unknown Source)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)
	at java.base/java.lang.Thread.run(Unknown Source)
Caused by: org.postgresql.util.PSQLException: ERROR: could not access file "decoderbufs": No such file or directory
	at org.postgresql.core.v3.QueryExecutorImpl.receiveErrorResponse(QueryExecutorImpl.java:2725)
	at org.postgresql.core.v3.QueryExecutorImpl.processResults(QueryExecutorImpl.java:2412)
	at org.postgresql.core.v3.QueryExecutorImpl.execute(QueryExecutorImpl.java:371)
	at org.postgresql.jdbc.PgStatement.executeInternal(PgStatement.java:502)
	at org.postgresql.jdbc.PgStatement.execute(PgStatement.java:419)
	at org.postgresql.jdbc.PgStatement.executeWithFlags(PgStatement.java:341)
	at org.postgresql.jdbc.PgStatement.executeCachedSql(PgStatement.java:326)
	at org.postgresql.jdbc.PgStatement.executeWithFlags(PgStatement.java:302)
	at org.postgresql.jdbc.PgStatement.execute(PgStatement.java:297)
	at io.debezium.connector.postgresql.connection.PostgresReplicationConnection.createReplicationSlot(PostgresReplicationConnection.java:459)
	at io.debezium.connector.postgresql.PostgresConnectorTask.start(PostgresConnectorTask.java:137)
	... 6 more


-> doc nó có config 

https://nightlies.apache.org/flink/flink-cdc-docs-release-3.2/docs/connectors/flink-sources/postgres-cdc/

decoding.plugin.name


3. permitsion

log flink 
Caused by: org.postgresql.util.PSQLException: ERROR: permission denied for database my_database

log db
postgres-1  | 2025-01-10 14:00:08.402 UTC [68] LOG:  statement: CREATE PUBLICATION dbz_publication FOR ALL TABLES;
postgres-1  | 2025-01-10 14:00:08.402 UTC [68] ERROR:  permission denied for database my_database


postgres=# \du
                                            List of roles
     Role name     |                         Attributes                         |      Member of      
-------------------+------------------------------------------------------------+---------------------
 admin             | Superuser, Create role, Create DB, Replication, Bypass RLS | {replication_group}
 data_etl          | Replication                                                | {replication_group}
 replication_group | Cannot login                                               | {}

postgres=# GRANT CREATE ON DATABASE my_database TO data_etl;
my_database=# GRANT SELECT ON ALL TABLES IN SCHEMA public TO data_etl;

Caused by: org.postgresql.util.PSQLException: ERROR: must be superuser to create FOR ALL TABLES publication

postgres-1  | 2025-01-10 14:03:46.429 UTC [91] LOG:  statement: CREATE PUBLICATION dbz_publication FOR ALL TABLES;
postgres-1  | 2025-01-10 14:03:46.429 UTC [91] ERROR:  must be superuser to create FOR ALL TABLES publication

-> chịu cho nó là supser user đã rồi tính 

my_database=# ALTER ROLE data_etl WITH SUPERUSER;
ALTER ROLE
my_database=# \du
                                            List of roles
     Role name     |                         Attributes                         |      Member of      
-------------------+------------------------------------------------------------+---------------------
 admin             | Superuser, Create role, Create DB, Replication, Bypass RLS | {replication_group}
 data_etl          | Superuser, Replication                                     | {replication_group}
 replication_group | Cannot login                                               | {}


4. table.exec.sink.not-null-enforcer

org.apache.flink.table.api.TableException: 
Column 'ID' is NOT NULL, however, a null value is being written into it. 
You can set job configuration 'table.exec.sink.not-null-enforcer'='DROP' to suppress this exception and drop such records silently.

-> SET 'table.exec.sink.not-null-enforcer' = 'DROP';

xong éo thấy dữ liệu gì

-> tạo lại bảng khác là oke nha

# sql
CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

# sql
INSERT INTO products (id, name, price) VALUES
    (10, 'Product A', 19.99),
    (5, 'Product B', 29.99),
    (122, 'Product C', 39.99);

# flink 
create temporary table products (
    id INT,
    name VARCHAR,
    price DECIMAL(10, 2),
    PRIMARY KEY (id) NOT ENFORCED
) WITH (
  'connector' = 'postgres-cdc',
  'hostname' = '10.208.164.167',
  'port' = '5431',
  'username' = 'data_etl',
  'password' = 'data_etl',
  'database-name' = 'my_database',
  'schema-name' = 'public',
  'table-name' = 'products',
  'slot.name' = 'flink',
  'decoding.plugin.name'= 'pgoutput'
);

select * from products;
    SQL Query Result (Table)                                                                                   
 Refresh: -                 Page: Last of 1  Updated: 14:23:44.884 

          id                           name        price
           1                      Product A        19.99
           2                      Product B        29.99
           3                      Product C        39.99

INSERT INTO myproducts (id,name) SELECT id, name FROM products;

select * from myproducts;

     SQL Query Result (Table)                                                                                   
 Refresh: 10 s    Page: Last of 1     Updated: 14:25:13.487 

          id                           name         Age
           1                      Product A      <NULL>
           2                      Product B      <NULL>
           3                      Product C      <NULL>

ref : https://github.com/gordonmurray/apache_flink_and_paimon/blob/main/jobs/job.sql   (oke)
link khác: 
https://github.com/wirelessr/paimon-trino-flink-playground/blob/main/README.md
https://github.com/Rekeyea/PaimonFlink/blob/main/Readme.md


recheck minio 

bash-5.1# mc alias set myminio http://10.208.164.167:9000 minio minio123
Added `myminio` successfully.
bash-5.1# mc ls mc myminio/paimon/warehouse/test_db.db/myproducts              
[2025-01-10 14:28:55 UTC]     0B bucket-0/
[2025-01-10 14:28:55 UTC]     0B index/
[2025-01-10 14:28:55 UTC]     0B manifest/
[2025-01-10 14:28:55 UTC]     0B schema/
[2025-01-10 14:28:55 UTC]     0B snapshot/
bash-5.1# mc cat  myminio/paimon/warehouse/test_db.db/myproducts/schema/schema-0 
{
  "version" : 2,
  "id" : 0,
  "fields" : [ {
    "id" : 0,
    "name" : "id",
    "type" : "INT NOT NULL"
  }, {
    "id" : 1,
    "name" : "name",
    "type" : "STRING"
  }, {
    "id" : 2,
    "name" : "Age",
    "type" : "INT"
  } ],
  "highestFieldId" : 2,
  "partitionKeys" : [ ],
  "primaryKeys" : [ "id" ],
  "options" : { },
  "comment" : "",
  "timeMillis" : 1736514829224
}


recheck postgres

my_database=# SELECT * FROM pg_stat_replication_slots;
    slot_name    | spill_txns | spill_count | spill_bytes | stream_txns | stream_count | stream_bytes | total_txns | total_bytes | stats_reset 
-----------------+------------+-------------+-------------+-------------+--------------+--------------+------------+-------------+-------------
 debezium_person |          0 |           0 |           0 |           0 |            0 |            0 |          0 |           0 | 
 flink           |          0 |           0 |           0 |           0 |            0 |            0 |          8 |       11769 | 
(2 rows)




