phải cấu hình metastore-site.xml không thi nó sẽ nhảy default DB_LOCATION_URI là file:// (local)

-> khi tạo thêm db nó sẽ báo lỗi k có quyền nhé

    <property>
        <name>hive.metastore.warehouse.dir</name>
        <value>s3a://paimonmetastore/warehouse</value>
    </property>

    <property>
        <name>fs.s3a.impl</name>
        <value>org.apache.hadoop.fs.s3a.S3AFileSystem</value>
    </property>


bash-5.1# mc alias set myminio http://10.208.164.167:9000 minio minio123
Added `myminio` successfully.
bash-5.1# mc ls myminio         
[2025-01-09 01:32:01 UTC]     0B catalog-test-bucket/
[2025-01-08 11:05:20 UTC]     0B paimonmetastore/
bash-5.1# mc ls myminio/paimonmetastore/
[2025-01-09 01:39:16 UTC]     0B warehouse/



Flink SQL> CREATE DATABASE medallion;

hive_db=# select * from public."DBS";
 DB_ID |         DESC          |               DB_LOCATION_URI                |   NAME    | OWNER_NAME | OWNER_TYPE | CTLG_NAME 
-------+-----------------------+----------------------------------------------+-----------+------------+------------+-----------
     1 | Default Hive database | s3a://paimonmetastore/warehouse              | default   | public     | ROLE       | hive
     2 |                       | s3a://paimonmetastore/warehouse/medallion.db | medallion |            | USER       | hive
(2 rows)

-> tạo thêm db s3a://paimonmetastore/warehouse/medallion.db
-> tạo thêm bucket trên s3 

bash-5.1# mc ls myminio/paimonmetastore/warehouse/
[2025-01-09 01:39:20 UTC]     0B bronze/
[2025-01-09 01:39:20 UTC]     0B medallion.db/

Flink SQL> INSERT INTO bronze (event_id, user_id, event_type, event_timestamp, raw_data)
> VALUES
>     ('E1', 'U1', 'click', TIMESTAMP '2025-01-01 12:30:45', '{"key": "value1"}'),
>     ('E2', 'U2', 'purchase', TIMESTAMP '2025-01-01 12:31:30', '{"key": "value2"}'),
>     ('E3', 'U1', 'click', TIMESTAMP '2025-01-01 12:32:10', '{"key": "value3"}'),
>     ('E4', 'U3', 'view', TIMESTAMP '2025-01-01 12:33:05', '{"key": "value4"}');
> 
[INFO] Submitting SQL update statement to the cluster...
[INFO] SQL update statement has been successfully submitted to the cluster:
Job ID: 96a90e65c2f7790e3706e3e092f2ae44

hive_db=# select * from public."SDS";
 SD_ID |                  INPUT_FORMAT                   | IS_COMPRESSED |                LOCATION                | NUM_BUCKETS |                  OUTPUT_FORMAT                   | SERDE_ID | CD_ID | IS_STOREDASSUBDIRECTORIES 
-------+-------------------------------------------------+---------------+----------------------------------------+-------------+--------------------------------------------------+----------+-------+---------------------------
     1 | org.apache.paimon.hive.mapred.PaimonInputFormat | f             | s3a://paimonmetastore/warehouse/bronze |           0 | org.apache.paimon.hive.mapred.PaimonOutputFormat |        1 |     1 | f
(1 row)
hive_db=# select * from public."COLUMNS_V2";
 CD_ID | COMMENT |   COLUMN_NAME   | TYPE_NAME | INTEGER_IDX 
-------+---------+-----------------+-----------+-------------
     1 |         | event_id        | string    |           0
     1 |         | user_id         | string    |           1
     1 |         | event_type      | string    |           2
     1 |         | event_timestamp | timestamp |           3
     1 |         | raw_data        | string    |           4
(5 rows)
hive_db=# select * from public."TBLS";
 TBL_ID | CREATE_TIME | DB_ID | LAST_ACCESS_TIME | OWNER | OWNER_TYPE | RETENTION  | SD_ID | TBL_NAME |   TBL_TYPE    | VIEW_EXPANDED_TEXT | VIEW_ORIGINAL_TEXT | IS_REWRITE_ENABLED 
--------+-------------+-------+------------------+-------+------------+------------+-------+----------+---------------+--------------------+--------------------+--------------------
      1 |  1736334407 |     1 |       1736334407 | root  | USER       | 2147483647 |     1 | bronze   | MANAGED_TABLE |                    |                    | f
(1 row)

-> DB_ID link tới ID trong db DBS




Database test_db already exists in Catalog default_catalog.

-> catalog > database > table








