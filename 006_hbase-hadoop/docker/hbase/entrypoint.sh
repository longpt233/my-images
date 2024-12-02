#!/bin/bash

sleep 60

$HBASE_HOME/bin/hbase-daemon.sh start zookeeper
sleep 5
$HBASE_HOME/bin/start-hbase.sh
sleep 10
jps

tail -f /dev/null  # lenh nay de treo shell -> khong thoat container 
exec $@
