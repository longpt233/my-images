#!/usr/bin/env bash

export HADOOP_CONF_DIR=/opt/spark/conf/hadoop-conf
cd /opt/spark

tail -f /dev/null
exec $@