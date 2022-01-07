#!/bin/bash

echo -e "\n"

/etc/init.d/ssh start

# $HADOOP_HOME/sbin/start-dfs.sh

echo -e "\n"

# $HADOOP_HOME/sbin/start-yarn.sh

tail -f /dev/null  # lenh nay de treo shell -> khong thoat container 

echo -e "\n"

