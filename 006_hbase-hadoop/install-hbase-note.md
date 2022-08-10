
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

<property>
    <name>hbase.zookeeper.quorum</name>
    <value>10.3.107.203,10.3.105.185,10.3.105.61</value>
</property>

 <property>
    <name>hbase.zookeeper.property.clientPort</name>
    <value>2181</value>
  </property>

  <property>
  <name>hbase.wal.provider</name>
  <value>filesystem</value>
</property>

</property>

```


```
nano hbase/conf/regionservers 
10.3.107.203
10.3.105.185
10.3.105.61
```

## 3. move

```
scp -r ~/hbase  10.3.105.61:/home/longpt
scp -r ~/hbase  10.3.105.185:/home/longpt
```

## 4. run 

```
start-hbase.sh

25172 HQuorumPeer    <>
12806 NameNode
31719 Jps
13163 SecondaryNameNode
21116 HMaster         <>
21518 HRegionServer   <>
13646 ResourceManager
```

```
25172 HQuorumPeer    <>
12806 DataNode
31719 Jps
21518 HRegionServer   <>
21332 NodeManager
```

- HQuorumPeer kiểu rep của zookeper ?

- test 

```
hbase shell 
hbase:001:0> status
1 active master, 0 backup masters, 2 servers, 1 dead, 1.0000 average load
```

## debug 

- Error: Could not find or load main class org.apache.hadoop.hbase.util.GetJavaProperty -> tải bin , not src [stack](https://stackoverflow.com/questions/60200870/can-not-find-or-load-main-class-org-apache-hadoop-hbase-util-hbaseconftool)

- không bật tắt, (bật k tắt được - treo stopping habse ......) 

```
TABLE                                                                                                                                            
ERROR: org.apache.hadoop.hbase.ipc.ServerNotRunningYetException: Server is not running yet                                         
        at org.apache.hadoop.hbase.master.HMaster.checkServiceStarted(HMaster.java:2822)                                           
        at org.apache.hadoop.hbase.master.MasterRpcServices.isMasterRunning(MasterRpcServices.java:1165)                                                  
        at org.apache.hadoop.hbase.shaded.protobuf.generated.MasterProtos$MasterService$2.callBlockingMethod(MasterProtos.java)
        at org.apache.hadoop.hbase.ipc.RpcServer.call(RpcServer.java:384)
        at org.apache.hadoop.hbase.ipc.CallRunner.run(CallRunner.java:131)
        at org.apache.hadoop.hbase.ipc.RpcExecutor$Handler.run(RpcExecutor.java:371)
        at org.apache.hadoop.hbase.ipc.RpcExecutor$Handler.run(RpcExecutor.java:351)

```

- thì thêm cái này vô hbase-site.xml 
```
<property>
  <name>hbase.wal.provider</name>
  <value>filesystem</value>
</property>

```

## ui 

- http://10.3.107.203:16010/master-status#storeStats

## ref

- https://www.unixmen.com/configure-distributed-hbase-cluster-on-centos-linux-7/
- https://www.tutorialspoint.com/hbase/hbase_installation.htm
- https://www.guru99.com/hbase-installation-guide.html
- https://stackoverflow.com/questions/29397659/hbase-installation-in-three-node-hadoop-cluster
- https://www.guru99.com/hbase-architecture-data-flow-usecases.html