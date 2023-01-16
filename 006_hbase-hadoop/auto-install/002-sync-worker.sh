#!/bin/bash

echo "hadoop intall at "${HADOOP_HOME}

export HADOOP_VER=2.7.0

scp -P 2395 hadoop-*.tar.gz longpt@10.5.92.80:/home/longpt
scp -P 2395 hadoop-*.tar.gz longpt@10.5.92.73:/home/longpt

ssh -p 2395 longpt@10.5.92.80 "tar -xzf hadoop-*.tar.gz && rm *.tar.gz"
ssh -p 2395 longpt@10.5.92.80 "mv /home/longpt/hadoop-${HADOOP_VER} /home/longpt/hadoop"


ssh -p 2395 longpt@10.5.92.73 "tar -xzf hadoop-*.tar.gz && rm *.tar.gz"
ssh -p 2395 longpt@10.5.92.73 "mv /home/longpt/hadoop-${HADOOP_VER} /home/longpt/hadoop"


scp -P 2395 ~/hadoop/etc/hadoop/* longpt@10.5.92.80:/home/longpt/hadoop/etc/hadoop/
scp -P 2395 ~/hadoop/etc/hadoop/* longpt@10.5.92.73:/home/longpt/hadoop/etc/hadoop/

