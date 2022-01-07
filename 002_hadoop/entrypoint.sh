#!/bin/bash

/etc/init.d/ssh start
$HADOOP_HOME/sbin/start-dfs.sh   # run dfs 

tail -f /dev/null  # lenh nay de treo shell -> khong thoat container 
exec $@
