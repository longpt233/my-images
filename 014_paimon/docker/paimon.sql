USE CATALOG default_catalog;

CREATE CATALOG catalog WITH (
    'type' = 'paimon',
    'metastore' = 'hive',
    'uri' = 'thrift://10.208.164.167:9083',
    'warehouse' = 's3://datalake/paimon',
    's3.endpoint' = 'http://10.208.164.167:9000',
    's3.access-key' = 'minio',  
    's3.secret-key' = 'minio123',
    's3.path.style.access' = 'true',
    'location-in-properties' = 'true'
);


USE CATALOG catalog;

CREATE DATABASE medallion;

USE medallion;

CREATE TABLE bronze (
    event_id STRING,
    user_id STRING,
    event_type STRING,
    event_timestamp TIMESTAMP(3),
    raw_data STRING,
    processing_time AS PROCTIME()
);

CREATE TABLE silver (
    event_id STRING,
    user_id STRING,
    event_type STRING,
    event_timestamp TIMESTAMP(3),
    raw_data STRING
);



SELECT hive_db.public."DBS"."NAME" AS database_name, hive_db.public."TBLS"."TBL_NAME" AS table_name, hive_db.public."SDS"."LOCATION" as path_hdfs
FROM hive_db.public."TBLS"
JOIN hive_db.public."DBS" ON hive_db.public."TBLS"."DB_ID" = hive_db.public."DBS"."DB_ID"
JOIN hive_db.public."SDS" ON hive_db.public."TBLS"."SD_ID" = hive_db.public."SDS"."SD_ID";

-> cái này tạo vớ vẩn mà k có trong hms là đến lúc đọc ra k thấy gì  (mặc dù đã có thu mục trên minio)

./bin/flink run ./lib/paimon-flink-action-0.8.1.jar postgres_sync_table \
 --warehouse s3://10.208.164.167:9000/datalake/paimon1 \
 --database paimon_db  \
 --table paimon_table  \
 --primary_keys "id,age"  \
 --partition_keys "age"  \
 --postgres_conf hostname=10.208.164.167  \
 --postgres_conf port=5431  \
 --postgres_conf username=data_etl  \
 --postgres_conf password=data_etl  \
 --postgres_conf database-name='my_database'  \
 --postgres_conf schema-name='public'  \
 --postgres_conf table-name='person'  \
 --postgres_conf slot.name='flink_paimon_cdc'     \
 --catalog_conf s3.endpoint=http://10.208.164.167:9000    \
 --catalog_conf metastore=hive \
    --catalog_conf uri=thrift://10.208.164.167:9083 


 --s3.access-key minio    \
 --s3.secret-key minio123    \
 --s3.path.style.access true \

./bin/flink  run    ./lib/paimon-flink-action-0.8.1.jar     postgres_sync_table  --warehouse s3://10.208.164.16/datalake/paimon  --database paimon_db   --table paimon_table   --primary_keys "id,age"   --partition_keys "age"   --postgres_conf hostname=10.208.164.167   --postgres_conf port=5431   --postgres_conf username=data_etl   --postgres_conf password=data_etl   --postgres_conf database-name='my_database'   --postgres_conf schema-name='public'   --postgres_conf table-name='person'   --postgres_conf slot.name='flink_paimon_cdc'      --s3.endpoint http://10.208.164.167:9000     --s3.access-key minio     --s3.secret-key minio123     --s3.path.style.access true 



./bin/flink run 
    ./lib/paimon-flink-action-0.8.1.jar \
    postgres_sync_table \
 --warehouse s3://10.208.164.16/datalake/paimon \
 --database paimon_db  \
 --table paimon_table  \
 --primary_keys "id,age"  \
 --partition_keys "age"  \
 --postgres_conf hostname=10.208.164.167  \
 --postgres_conf port=5431  \
 --postgres_conf username=data_etl  \
 --postgres_conf password=data_etl  \
 --postgres_conf database-name='my_database'  \
 --postgres_conf schema-name='public'  \
 --postgres_conf table-name='person'  \
 --postgres_conf slot.name='flink_paimon_cdc'     \
 --s3.endpoint http://10.208.164.167:9000    \
 --s3.access-key minio    \
 --s3.secret-key minio123    \
 --s3.path.style.access true 


 ./bin/flink run -D s3.endpoint=http://10.208.164.167:9000 \
  -D s3.access-key=minio \
  -D s3.secret-key=minio123 \
  -D s3.path.style.access=true \
  ./lib/paimon-flink-action-0.8.1.jar \
 --warehouse s3://datalake/paimon1 \
 --database paimon_db  \
 --table paimon_table  \
 --primary_keys "id,age"  \
 --partition_keys "age"  \
 --postgres_conf hostname=10.208.164.167  \
 --postgres_conf port=5431  \
 --postgres_conf username=data_etl  \
 --postgres_conf password=data_etl  \
 --postgres_conf database-name='my_database'  \
 --postgres_conf schema-name='public'  \
 --postgres_conf table-name='person'  \ 
 --postgres_conf slot.name='flink_paimon_cdc' \
    postgres_sync_table 



./bin/flink run ./lib/paimon-flink-action-0.8.1.jar postgres_sync_table \
   --classpath "file:///opt/flink/lib/paimon-s3-0.9.0.jar" \
 --warehouse s3://datalake/paimon1 \
 --database paimon_db  \
 --table paimon_table  \
 --primary_keys "id,age"  \
 --partition_keys "age"  \
 --postgres_conf hostname=10.208.164.167  \
 --postgres_conf port=5431  \
 --postgres_conf username=data_etl  \
 --postgres_conf password=data_etl  \
 --postgres_conf database-name='my_database'  \
 --postgres_conf schema-name='public'  \
 --postgres_conf table-name='person'  \
 --postgres_conf slot.name='flink_paimon_cdc'     \
 --catalog_conf s3.endpoint=http://10.208.164.167:9000    \
 --catalog_conf s3.access-key=minio    \
 --catalog_conf s3.path.style.access=true   \
 --catalog_conf metastore=hive \
 --catalog_conf uri=thrift://10.208.164.167:9083  \



--s3.access-key minio    \
 --s3.secret-key minio123    \
 --s3.path.style.access true \


 MinIO sử dụng một endpoint giống S3, nhưng có thể bạn cần phải chỉ định path.style.access=true để phù hợp với cách MinIO hoạt động
