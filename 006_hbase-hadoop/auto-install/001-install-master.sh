#!/bin/bash

# set java
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

# set version
export HADOOP_VER=2.7.0

# dir install
dir=/home/longpt
echo "current dir:"${dir}
wget https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VER}/hadoop-${HADOOP_VER}.tar.gz
tar -xzf hadoop-${HADOOP_VER}.tar.gz
mv hadoop-${HADOOP_VER} ${dir}/hadoop

# env  
export HADOOP_HOME="${dir}/hadoop"
export PATH=${PATH}:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin
export HADOOP_SSH_OPTS="-p 2395"

echo export HADOOP_HOME"="/home/longpt/hadoop>>~/.profile
echo export HADOOP_SSH_OPTS="\"-p 2395\"" >> ~/.profile

source ~/.profile

echo "hadoop intall at "${HADOOP_HOME}

# cop file cau hinh 
echo "cop file cau hinh"
cp ./conf/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh
cp ./conf/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml 
cp ./conf/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml 
cp ./conf/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
cp ./conf/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
cp ./conf/workers $HADOOP_HOME/etc/hadoop/workers
cp ./conf/slaves $HADOOP_HOME/etc/hadoop/slaves

# scp hadoop-*.tar.gz 10.3.105.61:
# scp hadoop-*.tar.gz 10.3.105.185:

# ssh -p 2395 longpt@10.3.105.185
# ssh -p 2395 longpt@10.3.105.61

# tar -xzf hadoop-*
# mv hadoop-2.7.0 hadoop
