#!/bin/bash

# set java
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

# set version
export HADOOP_VER=2.7.0

# vm to dir install
dir=$(pwd)
echo "current dir:"${dir}
wget https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VER}/hadoop-${HADOOP_VER}.tar.gz
tar -xzf hadoop-${HADOOP_VER}.tar.gz
mv hadoop-${HADOOP_VER} hadoop

# env  
export HADOOP_HOME=${dir}/hadoop
export PATH=${PATH}:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin

# cop file cau hinh 
mv ./conf/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh
mv ./conf/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml 
mv ./conf/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml 
mv ./conf/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
mv ./conf/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
mv ./conf/workers $HADOOP_HOME/etc/hadoop/workers

# scp hadoop-*.tar.gz 10.3.105.61:
# scp hadoop-*.tar.gz 10.3.105.185:

# ssh -p 2395 longpt@10.3.105.185
# ssh -p 2395 longpt@10.3.105.61

# tar -xzf hadoop-*
# mv hadoop-2.7.0 hadoop
