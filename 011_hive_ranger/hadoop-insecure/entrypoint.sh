#!/bin/bash

/usr/local/hadoop/bin/hdfs --daemon start namenode
sleep 3
/usr/local/hadoop/bin/hdfs --daemon start datanode
sleep 3
echo "insecure" && jps

# /usr/local/hive/bin/schematool -dbType postgres -initSchema --verbose

/usr/local/hive/bin/schematool -dbType postgres -initSchema 2>&1 | grep -q "Database already exists" || /usr/local/hive/bin/schematool -dbType postgres -initSchema
/usr/local/hive/bin/hive --service metastore

exec $@
