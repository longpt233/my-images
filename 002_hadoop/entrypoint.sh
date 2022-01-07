#!/bin/bash

$HADOOP_HOME/sbin/start-dfs.sh   # run dfs 

tail -f /dev/null  # lenh nay de treo shell -> khong thoat container 
exec $@
