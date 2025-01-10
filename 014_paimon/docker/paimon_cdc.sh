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
 --warehouse s3a://datalake/paimon1 \
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
 --catalog_conf s3a.endpoint=http://10.208.164.167:9000    \
 --catalog_conf s3a.access-key=minio    \
 --catalog_conf s3a.path.style.access=true   \
 --catalog_conf s3a.secret-key=minio123   \
 --catalog_conf metastore=hive \
 --catalog_conf uri=thrift://10.208.164.167:9083  \

Caused by: java.lang.RuntimeException: java.lang.ClassNotFoundException: Class org.apache.hadoop.fs.s3a.S3AFileSystem not found


-> thiếu thư viện

long@hello:/data/repo/my-images/014_paimon/docker$ docker cp ./jars/hadoop-aws-3.3.5.jar  jobmanager:/opt/flink/lib/hadoop-aws-3.3.5.jar 
Successfully copied 762kB to jobmanager:/opt/flink/lib/hadoop-aws-3.3.5.jar
long@hello:/data/repo/my-images/014_paimon/docker$ docker cp ./jars/hadoop-aws-3.3.5.jar  docker-taskmanager-1:/opt/flink/lib/hadoop-aws-3.3.5.jar 
Successfully copied 762kB to docker-taskmanager-1:/opt/flink/lib/hadoop-aws-3.3.5.jar
long@hello:/data/repo/my-images/014_paimon/docker$ docker cp ./jars/hadoop-aws-3.3.5.jar  docker-taskmanager-2:/opt/flink/lib/hadoop-aws-3.3.5.jar 
Successfully copied 762kB to docker-taskmanager-2:/opt/flink/lib/hadoop-aws-3.3.5.jar

--s3.access-key minio    \
 --s3.secret-key minio123    \
 --s3.path.style.access true \


 MinIO sử dụng một endpoint giống S3, nhưng có thể bạn cần phải chỉ định path.style.access=true để phù hợp với cách MinIO hoạt động


--warehouse s3a://10.208.164.167:9000/datalake/paimon1 \
->  S3Guard is disabled on this bucket: 10.208.164.167. chứng tỏ chố warehouse này là điền buket rồi, không có ip


./bin/flink run  \
-Dfs.s3.endpoint=http://10.208.164.167:9000    \
-Ds3.path.style.access=true   \
-DAWS_ACCESS_KEY_ID=minio \
-DAWS_SECRET_KEY=minio123 \
./lib/paimon-flink-action-0.9.0.jar postgres_sync_table \
--warehouse s3a://datalake/paimon1 \
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
--catalog_conf metastore=hive \
--catalog_conf uri=thrift://10.208.164.167:9083  

-D s3.endpoint=http://10.208.164.167:9000    \
-D s3.access-key=minio    \
-D s3.path.style.access=true   \
-D s3.secret-key=minio123   \


-Ds3.access-key=minio    \
-Ds3.secret-key=minio123   \


root@ff6201e1d778:/opt/flink# tail -n 1000 log/flink--client-ff6201e1d778.log



./bin/flink run  \
./lib/paimon-flink-action-0.9.0.jar postgres_sync_table \
--warehouse s3://paimon/warehouse \
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



--catalog_conf metastore=hive \
--catalog_conf uri=thrift://10.208.164.167:9083  


./bin/flink run  \
-Dfs.s3.endpoint=http://10.208.164.167:9000    \
-Ds3.path.style.access=true   \
-DAWS_ACCESS_KEY_ID=minio \
-DAWS_SECRET_KEY=minio123 \
./lib/paimon-flink-action-0.9.0.jar postgres_sync_table \
--warehouse s3://paimon/warehouse \
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
--postgres_conf slot.name='flink_paimon_cdc' 


-> Missing required options are:

s3.access-key
s3.secret-key


./bin/flink run  \
-Ds3.endpoint=http://10.208.164.167:9000    \
-Ds3.path.style.access=true   \
-Ds3.access-key=minio \
-Ds3.secret-key=minio123 \
./lib/paimon-flink-action-0.9.0.jar postgres_sync_table \
--warehouse s3://paimon/warehouse \
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
--postgres_conf slot.name='flink_paimon_cdc' 


-> không set được  = flink 

As explained on https://nightlies.apache.org/flink/flink-docs-stable/docs/deployment/filesystems/s3/#configure-access-credentials you should use IAM or Access Keys which you configure in flink-conf.yaml. You can't set the credentials in code, because the S3 plugins are loaded via plugins.

nó bảo là có thể dùng được bằng spark nhưng mà flink thì chưa 

sparkContext.hadoopConfiguration.set("fs.s3a.access.key","***")



./bin/flink run  \
./lib/paimon-flink-action-0.9.0.jar postgres_sync_table \
--warehouse s3://paimon/warehouse \
--database paimon_db  \
--table paimon_table  \
--primary_keys "id"  \
--postgres_conf hostname=10.208.164.167  \
--postgres_conf port=5431  \
--postgres_conf username=data_etl  \
--postgres_conf password=data_etl  \
--postgres_conf database-name='my_database'  \
--postgres_conf schema-name='public'  \
--postgres_conf table-name='person'  \
--postgres_conf slot.name='flink_paimon_cdc'  \
--postgres_conf decoding.plugin.name='pgoutput'

--partition_keys "age"  \


./bin/flink run  \
./lib/paimon-flink-action-0.8.1.jar postgres_sync_table \
--warehouse hdfs://10.208.164.172:9000/test \
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
--postgres_conf slot.name='flink_paimon_cdc'  \
--postgres_conf decoding.plugin.name='pgoutput'


./bin/flink run  \
./lib/paimon-flink-action-0.8.1.jar postgres_sync_table \
--warehouse hdfs://10.208.164.172:9000/test \
--database paimon_db  \
--table paimon_table  \
--primary_keys "id"  \
--postgres_conf hostname=10.208.164.167  \
--postgres_conf port=5431  \
--postgres_conf username=admin  \
--postgres_conf password=admin  \
--postgres_conf database-name='my_database'  \
--postgres_conf schema-name='public'  \
--postgres_conf table-name='person'  \
--postgres_conf slot.name='flink_paimon_cdc'  \
--postgres_conf decoding.plugin.name='pgoutput'


-Dexecution.checkpointing.interval=<interval>
https://paimon.apache.org/docs/1.0/cdc-ingestion/overview/#checkpointing

