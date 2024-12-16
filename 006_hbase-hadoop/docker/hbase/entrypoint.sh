#!/bin/bash

sleep 10

$HBASE_HOME/bin/hbase-daemon.sh start zookeeper
sleep 5

# $HBASE_HOME/bin/start-hbase.sh
$HBASE_HOME/bin/hbase-daemon.sh start master
sleep 5
$HBASE_HOME/bin/hbase-daemon.sh start regionserver
# $HBASE_HOME/bin/hbase-daemon.sh start backup

# $HBASE_HOME/bin/hbase zkcli
# $HBASE_HOME/bin/hbase shell
# list
# tail -n 1000 $HBASE_HOME/log
# /usr/local/phoenix/bin/sqlline.py localhost
# 0: jdbc:phoenix:localhost> SHOW TABLES;

sleep 10
jps

# for test phoenix hbase working ?
/usr/local/phoenix/bin/sqlline.py localhost /usr/local/phoenix/examples/WEB_STAT.sql

# run notebook
nohup python3 -m jupyterlab --ip=0.0.0.0 --port=18080 --NotebookApp.token=1111 --allow-root > /dev/null &

# tail -f  $HBASE_HOME/log
tail -f /dev/null  # lenh nay de treo shell -> khong thoat container 
exec $@
