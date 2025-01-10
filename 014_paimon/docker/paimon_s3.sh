


CREATE CATALOG paimon_catalog WITH (
    'type' = 'paimon',
    'warehouse' = 's3:///paimon/warehouse',
    's3.endpoint' = 'http://10.208.164.167:9000',
    's3.access-key' = 'minio',  
    's3.secret-key' = 'minio123',
    's3.path.style.access' = 'true',
    'location-in-properties' = 'true'
);

[ERROR] Could not execute SQL statement. Reason:
java.lang.IllegalArgumentException: bucket is null/empty


-> 3 gạch lol s3:///

với lại chỉ cần tạo bucket paimon là được, k cần tạo thư mục vì tạo mà k có file nó cũng mất.


CREATE CATALOG paimon_catalog WITH (
    'type' = 'paimon',
    'warehouse' = 's3://paimon/warehouse',
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

INSERT INTO test7 (event_id, user_id)
VALUES
('E1', 'U1');