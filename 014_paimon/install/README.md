liệu có chạy được flink cdc trên yarn không cho  tích hợp được nhiều vào yarn

debezium mục postgresql-when-things-go-wrong

https://debezium.io/documentation/reference/stable/connectors/postgresql.html#postgresql-when-things-go-wrong

debezium quyền tối thiểu, với lại dùng với addon pgoutput

https://debezium.io/documentation/reference/stable/connectors/postgresql.html#postgresql-replication-user-privileges


Paimon có thể dùng với trino
https://paimon.apache.org/docs/master/engines/trino/

Paimon có thể dùng dưới dang spark (ghi đọc bthg, tuy nhiên k tự cdc được)
https://paimon.apache.org/docs/1.0/spark/quick-start/

	

Paimon dùng LMS tree để tổ chức dữ liệu


Streaming lakehouse: các công nghệ: 
- Spark and Apache Kudu
- Apache Flink and Apache Hudi
- Apache Flink and Apache Paimon

https://www.alibabacloud.com/blog/apache-paimon-streaming-lakehouse-is-coming_601357

Compare paimon - hudi: Paimon provides better read and write performance than Hudi and requires less memory

https://www.alibabacloud.com/blog/building-a-streaming-lakehouse-performance-comparison-between-paimon-and-hudi_601013



paimon flink hms

https://techjogging.com/access-minio-s3-storage-prestodb-cluster-hive-metastore.html

https://techjogging.com/standalone-hive-metastore-presto-docker.html


# Các hướng để ghi lên trên paimon

1. paimon

dùng thừ viện paimon-flink-action

Paimon cdc hỗ trợ 

https://paimon.apache.org/docs/1.0/cdc-ingestion/kafka-cdc/

mysql, postgres, mongo, kafka

```shell
<FLINK_HOME>/bin/flink run \
    /path/to/paimon-flink-action-1.0.0.jar \
    postgres_sync_table
    --warehouse <warehouse_path> \
    --database <database_name> \
    --table <table_name> \
```

-> tốt nhất là dùng kk cho thành 1 mối


```shell
<FLINK_HOME>/bin/flink run \
    /path/to/paimon-flink-action-1.0.0.jar \
    kafka_sync_table \
    --warehouse hdfs:///path/to/warehouse \
    --database test_db \
    --table test_table \
    --partition_keys pt \
    --primary_keys pt,uid \
    --computed_column '_year=year(age)' \
    --kafka_conf properties.bootstrap.servers=127.0.0.1:9020 \
    --kafka_conf topic=order \
    --kafka_conf properties.group.id=123456 \
    --kafka_conf value.format=canal-json \
    --catalog_conf metastore=hive \
    --catalog_conf uri=thrift://hive-metastore:9083 \
    --table_conf bucket=4 \
    --table_conf changelog-producer=input \
    --table_conf sink.parallelism=4
```

Paimon cdc kafka hỗ trợ: 

```
Canal CDC 	
Debezium CDC 	   -> chọn cái này cho lành
Maxwell CDC 	
OGG CDC 	
JSON 	
aws-dms-json 
```


không thấy chạy được 

2. flink

thử tạo bảng tạm xong sau đó insert vào db

https://github.com/gordonmurray/apache_flink_and_paimon/blob/main/jobs/job.sql

```
USE CATALOG default_catalog;

CREATE CATALOG s3_catalog WITH (
    'type' = 'paimon',
    'warehouse' = 's3://my-test-bucket/paimon'
);

USE CATALOG s3_catalog;

CREATE DATABASE IF NOT EXISTS my_database;

USE my_database;

CREATE TABLE myproducts (
    id INT PRIMARY KEY NOT ENFORCED,
    name VARCHAR,
    price DECIMAL(10, 2)
);

create temporary table products (
    id INT,
    name VARCHAR,
    price DECIMAL(10, 2),
    PRIMARY KEY (id) NOT ENFORCED
) WITH (
    'connector' = 'mysql-cdc',
    'connection.pool.size' = '10',
    'hostname' = 'mariadb',
    'port' = '3306',
    'username' = 'root',
    'password' = 'rootpassword',
    'database-name' = 'mydatabase',
    'table-name' = 'products'
);

SET 'execution.checkpointing.interval' = '10 s';

INSERT INTO myproducts (id,name) SELECT id, name FROM products;
```

hỗ trợ db trực tiếp  flink-sql-connector-postgres-cdc-3.2.1.jar


https://nightlies.apache.org/flink/flink-cdc-docs-release-3.2/docs/connectors/flink-sources/postgres-cdc/

```
CREATE TABLE shipments (
  shipment_id INT,
  order_id INT,
  origin STRING,
  destination STRING,
  is_arrived BOOLEAN
) WITH (
  'connector' = 'postgres-cdc',
  'hostname' = 'localhost',
  'port' = '5432',
  'username' = 'postgres',
  'password' = 'postgres',
  'database-name' = 'postgres',
  'schema-name' = 'public',
  'table-name' = 'shipments',
  'slot.name' = 'flink',
   -- experimental feature: incremental snapshot (default off)
  'scan.incremental.snapshot.enabled' = 'true'
);

-- read snapshot and binlogs from shipments table
SELECT * FROM shipments;




```

hỗ trợ kafka. debezium 

https://nightlies.apache.org/flink/flink-docs-master/docs/connectors/table/formats/debezium/

```
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
```


3. flink cdc



https://nightlies.apache.org/flink/flink-cdc-docs-release-3.2/docs/connectors/pipeline-connectors/paimon/



```
source:
  type: mysql
  name: MySQL Source
  hostname: 127.0.0.1
  port: 3306
  username: admin
  password: pass
  tables: adb.\.*, bdb.user_table_[0-9]+, [app|web].order_\.*
  server-id: 5401-5404

sink:
  type: paimon
  name: Paimon Sink
  catalog.properties.metastore: filesystem
  catalog.properties.warehouse: /path/warehouse

pipeline:
  name: MySQL to Paimon Pipeline
  parallelism: 2
```