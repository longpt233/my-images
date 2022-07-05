
## 1. download 

```
mkdir hbase
cd hbase
wget https://dlcdn.apache.org/hbase/2.4.13/hbase-2.4.13-bin.tar.gz
tar -zxvf hbase-2.4.13-src.tar.gz 
mv hbase-2.4.13 hbase

```



## 2. conf 

```
nano conf/hbase-env.sh
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
source  conf/hbase-env.sh

```

```
nano conf/hbase-site.xml
 <property>
    <name>hbase.cluster.distributed</name>
    <value>true</value>
  </property>
  <property>
    <name>hbase.tmp.dir</name>
    <value>./tmp</value>
  </property>
  <property>
    <name>hbase.unsafe.stream.capability.enforce</name>
    <value>false</value>
  </property>


 <property>
      <name>hbase.zookeeper.property.dataDir</name>
      <value>/home/longpt/zookeeper</value>
   </property>

<property>
   <name>hbase.rootdir</name>
   <value>hdfs://10.3.107.203:9000/hbase</value>
</property>

```



## debug 

- Error: Could not find or load main class org.apache.hadoop.hbase.util.GetJavaProperty -> tải bin , not src [stack](https://stackoverflow.com/questions/60200870/can-not-find-or-load-main-class-org-apache-hadoop-hbase-util-hbaseconftool)

- 

```

```
