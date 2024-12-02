#!/bin/bash

# /etc/init.d/ssh start
# $HADOOP_HOME/sbin/start-dfs.sh   # run dfs 

sleep 10
/usr/local/hadoop/bin/hdfs --daemon start namenode
sleep 10
/usr/local/hadoop/bin/hdfs --daemon start datanode
sleep 10
echo "insecure" && jps


tail -f /dev/null  # lenh nay de treo shell -> khong thoat container 
exec $@
