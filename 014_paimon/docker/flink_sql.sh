Flink SQL> CREATE CATALOG hive_catalog WITH (
>   'type'='iceberg',
>   'catalog-type'='hive',
>   'uri'='thrift://172.21.92.171:32141',
>   'clients'='5',
>   'property-version'='1',
>   'warehouse'='s3a://lsk/'
> );
2021-09-07 11:11:10,425 INFO  org.apache.hadoop.hive.conf.HiveConf                         [] - Found configuration file null
2021-09-07 11:11:15,701 INFO  org.apache.hadoop.hive.metastore.HiveMetaStoreClient         [] - Trying to connect to metastore with URI thrift://172.21.92.171:32141
2021-09-07 11:11:15,751 INFO  org.apache.hadoop.hive.metastore.HiveMetaStoreClient         [] - Opened a connection to metastore, current connections: 1
2021-09-07 11:11:15,795 INFO  org.apache.hadoop.hive.metastore.HiveMetaStoreClient         [] - Connected to metastore.
[INFO] Catalog has been created.

Flink SQL> use catalog hive_catalog;

Flink SQL> show databases;
default

Flink SQL> show tables;
[INFO] Result was empty.

Flink SQL> CREATE TABLE bench (
>   id INT,
>   val INT,
>   num INT,
>   location INT)
> WITH (
>     'connector' = 'iceberg',
>     'path' = 's3a://lsk/demo',
>     'fs.s3a.access.key' = '******',
>     'fs.s3a.secret.key' = '******',
>     'fs.s3a.endpoint' = 'http://172.21.92.176:7480',
>     'fs.s3a.aws.credentials.provider' = 'org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider',
>     'fs.s3a.impl' = 'org.apache.hadoop.fs.s3a.S3AFileSystem',
>     'fs.s3a.path.style.access' = 'true',
>     'hive.metastore.uris' = 'thrift://172.21.92.171:32141',
>     'hive.metastore.warehouse.dir' = 's3a://lsk/'
> );
[ERROR] Could not execute SQL statement. Reason:
java.io.IOException: Mkdirs failed to create file:/user/hive/warehouse/bench/metadata (exists=false, cwd=file:/home/shengkui.leng)

Flink SQL>


./bin/sql-client.sh embedded -j /Users/openinx/software/apache-iceberg/flink-runtime/build/libs/iceberg-flink-runtime-5f90476.jar shell


Flink SQL> CREATE TABLE iceberg_table (
>     id   BIGINT,
>     data STRING
> ) WITH (
>     'connector'='iceberg',
>     'catalog-name'='hive_prod',
>     'uri'='thrift://localhost:9083',
>     'warehouse'='file:///Users/openinx/test/iceberg-warehouse'
> );
[INFO] Table has been created.

Flink SQL> INSERT INTO iceberg_table values (1, 'AAA'), (2, 'BBB'), (3, 'CCC');
[INFO] Submitting SQL update statement to the cluster...
[INFO] Table update statement has been successfully submitted to the cluster:
Job ID: c9742d48cbd35502f9a3093d0d668543

Flink SQL> select * from iceberg_table ;
+----+------+
| id | data |
+----+------+
|  1 |  AAA |
|  2 |  BBB |
|  3 |  CCC |
+----+------+
3 rows in set



This issue is caused by the version of hive-metastore. I changed the hive to 2.3.9, then it's ok to create table and insert in flink sql client.

-> https://github.com/apache/iceberg/issues/3079