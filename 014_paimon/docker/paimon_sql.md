1. sql init

```
./bin/sql-client.sh
./bin/sql-client.sh embedded -j /Users/openinx/software/apache-iceberg/flink-runtime/build/libs/iceberg-flink-runtime-5f90476.jar shell
```

2. kết nối tới catalog 

giống như thằng trino kết nối tới hive thì cần cấu hình của hive.properties (bao gồm thông tin thrift + storage = core và hdfs site)

flink cũng kết nối tới hive = hive-site.xml (cx bao gồm thông tin thrift + s3 storage chẳng hạn)

mỗi lần tắt đi bật lại nó sẽ mất hết catalog đã  có

```sql
Flink SQL> show catalogs;
+-----------------+
|    catalog name |
+-----------------+
| default_catalog |
+-----------------+
1 row in set

Flink SQL> show databases;
+------------------+
|    database name |
+------------------+
| default_database |
+------------------+
1 row in set

```

mỗi lần bật lại sql phải tạo lại catalog: 


https://nightlies.apache.org/flink/flink-docs-release-1.20/docs/connectors/table/hive/hive_catalog/

https://paimon.apache.org/docs/master/concepts/catalog/ : 
-  Filesystem Catalog

```
https://paimon.apache.org/docs/master/flink/sql-ddl/#create-filesystem-catalog
-- Flink SQL
CREATE CATALOG my_catalog WITH (
    'type' = 'paimon',
    'warehouse' = 'hdfs:///path/to/warehouse'
);

```
-  Hive Catalog 

```
CREATE CATALOG my_hive WITH (
    'type' = 'paimon',
    'metastore' = 'hive',
    -- 'warehouse' = 'hdfs:///path/to/warehouse', default use 'hive.metastore.warehouse.dir' in HiveConf  -> thế mà ở dưới mình chỉnh mãi k được thôi kệ đi tính sau. có khi dùng luôn catalog của file system luôn cho lành
);
```


(k biết cấu hình lưu lại ở đâu hic để mình không cần tạo lại catalog)

```sql
Flink SQL> 
create catalog paimon_default_catalog
with ( 'type'='paimon',
      'metastore'='hive',
      'hive-conf-dir'='/opt/flink/conf/',
      'location-in-properties'='false');

khi thu hien insert: 
'location-in-properties'='true'
-> Mkdirs failed to create /user/hive/warehouse/test_db.db/test111111/bucket-0

'location-in-properties'='false'
-> Mkdirs failed to create s3a://hive/warehouse/test_db.db/test11222/bucket-0


Flink SQL> use catalog paimon; 
[INFO] Execute statement succeeded.

Flink SQL> show databases;
+---------------+
| database name |
+---------------+
|       default |
|     medallion |
|       test_db |
+---------------+
3 rows in set

Flink SQL> use database test_db;
[ERROR] Could not execute SQL statement. Reason:
org.apache.flink.sql.parser.impl.ParseException: Encountered "test_db" at line 1, column 14.
Was expecting one of:
    <EOF> 
    ";" ...
    "." ...

Flink SQL> use test_db;
[INFO] Execute statement succeeded.


Flink SQL> show tables;
+------------+
| table name |
+------------+
| test111111 |
+------------+
1 row in set



Flink SQL> 

CREATE TABLE bronze (
    event_id STRING,
    user_id STRING,
    event_type STRING,
    event_timestamp TIMESTAMP(3),
    raw_data STRING,
    processing_time AS PROCTIME()
);

./bin/sql-client.sh
Flink SQL> 
CREATE CATALOG paimon_catalog WITH (
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
use catalog paimon_catalog;
create database test_db;
use test_db;
CREATE TABLE test7 (
    event_id STRING,
    user_id STRING);

-> nó bảo thằng hms tạo folder trên minio chứ flink nó k có pass gì luôn ấy 

INSERT INTO test8 (event_id, user_id)
VALUES
('E1', 'U1');

Flink SQL> select * from test7;

                              SQL Query Result (Table)                                                                                   
 Refresh: 1 min    Page: Last of 1       Updated: 01:42:57.194 

        event_id                        user_id
              E1                             U1
              E1                             U1


Q Quit    + Inc Refresh     G Goto Page       N Next Page        O Open Row                           
R Refresh - Dec Refresh     L Last Page       P Prev Page                          

bash-5.1# mc cat myminio/datalake/paimon/khac_warehouse_db.db/test8/schema/schema-0
{
  "version" : 3,
  "id" : 0,
  "fields" : [ {
    "id" : 0,
    "name" : "event_id",
    "type" : "STRING"
  }, {
    "id" : 1,
    "name" : "user_id",
    "type" : "STRING"
  } ],
  "highestFieldId" : 1,
  "partitionKeys" : [ ],
  "primaryKeys" : [ ],
  "options" : { },
  "comment" : "",
  "timeMillis" : 1736473836708
}
bash-5.1# mc ls myminio/hive/warehouse/khac_warehouse_db.db/test8
[2025-01-10 01:50:36 UTC]     0B STANDARD /

-> nó tạo cả schema trên minio lẫn duwois hms éo hiểu, tạo path ở 2 nơi, dữ liệu thì lưu bên kia (foler warehouse chỉ định)

 SD_ID | INPUT_FORMAT         | IS_COMPRESSED |                    LOCATION                     | NUM_BUCKETS | OUTPUT_FORMAT          | SERDE_ID | CD_ID |IS_STOREDASSUBDIRECTORIES 
-------+-...------------------+---------------+-------------------------------------------------+-------------+-...--------------------+----------+-------+---------------------------
     1 | ...PaimonInputFormat | f             | s3a://hive/warehouse/test_db.db/test111111      |           0 | ....PaimonOutputFormat |        1 |     1 | f
     2 | ...PaimonInputFormat | f             | s3a://hive/warehouse/test_db.db/test11222       |           0 | ....PaimonOutputFormat |        2 |     2 | f
     3 | ...PaimonInputFormat | f             | s3a://hive/warehouse/test_db.db/test4444        |           0 | ....PaimonOutputFormat |        3 |     3 | f
     4 | ...PaimonInputFormat | f             | s3a://hive/warehouse/test_db.db/test5555        |           0 | ....PaimonOutputFormat |        4 |     4 | f
     5 | ...PaimonInputFormat | f             | s3a://hive/warehouse/test_db.db/test66          |           0 | ....PaimonOutputFormat |        5 |     5 | f
     6 | ...PaimonInputFormat | f             | s3a://hive/warehouse/test_db.db/test7           |           0 | ....PaimonOutputFormat |        6 |     6 | f
     7 | ...PaimonInputFormat | f             | s3a://hive/warehouse/test_paimon_db.db/test7    |           0 | ....PaimonOutputFormat |        7 |     7 | f
     8 | ...PaimonInputFormat | f             | s3a://hive/warehouse/khac_warehouse_db.db/test8 |           0 | ....PaimonOutputFormat |        8 |     8 | f


-> thôi khả năng dẹp cái hms đi, chạy chay cho dễ

có thể nó liên quan tới cấu hình location-in-properties, nma quá mệt rồi

https://paimon.apache.org/docs/0.8/maintenance/configurations/#hivecatalogoptions

https://nightlies.apache.org/flink/flink-docs-stable/docs/connectors/table/hive/overview/#connecting-to-hive

https://github.com/apache/paimon/issues/2729

```

-> giờ nó sẽ tạo tbls tại db postgres tương ứng tỏng db hive


# nếu cố tình chạy bằng hive mà muốn chỉnh path của warehouse nó báo lỗi gì ấy 

```sql
create catalog test7
with ( 'type'='paimon',
    'metastore'='hive',
    'hive-conf-dir'='/opt/flink/conf/',
    -- 'uri' = 'thrift://10.208.164.167:9083',
    -- 'warehouse' = 's3://catalog-test-bucket/warehouse',  -> không cần điền mấy thông tin này vì nó phải ăn theo config hive-site.xml mà mình cấu hình bằng hive-conf-dir
    -- 's3.endpoint' = 'http://10.208.164.167:9000',
    -- 's3.access-key' = 'minio',  
    -- 's3.secret-key' = 'minio123',
    -- 's3.path.style.access' = 'true',
    'location-in-properties'='true');
Not Found: s3://catalog-test-bucket/warehouse/user.sys


Flink SQL> CREATE CATALOG catalog_test1111 WITH (
>     'type' = 'paimon',
>     'metastore' = 'hive',
>     'uri' = 'thrift://10.208.164.167:9083',
>     'warehouse' = 's3://catalog-test-bucket',
>     's3.endpoint' = 'http://10.208.164.167:9000',
>     's3.access-key' = 'minio',  
>     's3.secret-key' = 'minio123',
>     's3.path.style.access' = 'true',
>     'location-in-properties' = 'false'
> );
[ERROR] Could not execute SQL statement. Reason:
java.lang.IllegalArgumentException: path must be absolute    -> catalog phải tạo ở 1 thư mục, không được tạo tạị 1 bucket, giống như mặc định 
warehouse là s3a://paimonmetastore/warehouse

Flink SQL> CREATE CATALOG catalog_test4444 WITH (
>     'type' = 'paimon',
>     'metastore' = 'hive',
>     'uri' = 'thrift://10.208.164.167:9083',
>     'warehouse' = 's3://catalog-test-bucket/test',
>     's3.endpoint' = 'http://10.208.164.167:9000',
>     's3.access-key' = 'minio',  
>     's3.secret-key' = 'minio123',
>     's3.path.style.access' = 'true',
>     'location-in-properties' = 'false'
> );
> 
[INFO] Execute statement succeeded.

```

nói chung cx k muốn chỉnh lại chỗ này vì k hiểu cơ chế của nó 

mình sẽ khogon chỉnh dược warehouse vì nó là cấu hình của hive ?

```sql
SELECT hive_db.public."DBS"."NAME" AS database_name, hive_db.public."TBLS"."TBL_NAME" AS table_name, hive_db.public."SDS"."LOCATION" as path_hdfs
FROM hive_db.public."TBLS"
JOIN hive_db.public."DBS" ON hive_db.public."TBLS"."DB_ID" = hive_db.public."DBS"."DB_ID"
JOIN hive_db.public."SDS" ON hive_db.public."TBLS"."SD_ID" = hive_db.public."SDS"."SD_ID";
```

-> cái này tạo vớ vẩn mà k có trong hms là đến lúc đọc ra k thấy gì  (mặc dù đã có thu mục trên minio)

2.  paimon local filesystem

```sql
CREATE CATALOG my_catalog2 WITH (
    'type' = 'paimon',
    'warehouse' = 's3://catalog-test-bucket/warehouse',
    's3.endpoint' = 'http://10.208.164.167:9000',
    's3.access-key' = 'minio',  
    's3.secret-key' = 'minio123',
    's3.path.style.access' = 'true'
);


CREATE TABLE bronze (
    event_id STRING,
    user_id STRING,
    event_type STRING,
    event_timestamp TIMESTAMP(3),
    raw_data STRING,
    processing_time AS PROCTIME()
);


```

![alt text](image-1.png)


```sql
INSERT INTO bronze (event_id, user_id, event_type, event_timestamp, raw_data)
VALUES
('E1', 'U1', 'click', TIMESTAMP '2025-01-01 12:30:45', '{"key": "value1"}'),
('E2', 'U2', 'purchase', TIMESTAMP '2025-01-01 12:31:30', '{"key": "value2"}');
```


![alt text](image.png)




```

show catalogs;
show databases;
show tables;

show current catalogs;
show current databases;

```





