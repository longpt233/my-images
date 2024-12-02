#!/bin/bash

sleep 10

$HBASE_HOME/bin/hbase-daemon.sh start zookeeper
sleep 5

# $HBASE_HOME/bin/start-hbase.sh
$HBASE_HOME/bin/hbase-daemon.sh start master
$HBASE_HOME/bin/hbase-daemon.sh start regionserver
# $HBASE_HOME/bin/hbase-daemon.sh start backup


# $HBASE_HOME/bin/hbase zkcli

sleep 10
jps

tail -f /dev/null  # lenh nay de treo shell -> khong thoat container 
exec $@
