## info

```
ssh -p 2395 longpt@10.3.107.203  >master
ssh -p 2395 longpt@10.3.105.185
ssh -p 2395 longpt@10.3.105.61
```

## 1.  ssh

> master 
```
ssh-keygen -b 4096
less /home/longpt/.ssh/id_rsa.pub

```

> woker 

```
ssh-keygen
nano /home/longpt/.ssh/authorized_keys
```

- chú ý cũng cần cop cả vào master vì lúc start-dfs.sh nó cũng ssh tới localhost.

## 2. download hadoop 

```
wget http://apache.cs.utah.edu/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz
tar -xzf hadoop-3.3.1.tar.gz
mv hadoop-3.3.1 hadoop
```

## 3. bin path

- hadoop là thư mục giải nén ở bên trên

```
nano /home/longpt/.profile
/home/longpt/hadoop/bin:/home/longpt/hadoop/sbin:$PATH

nano /home/longpt/.bashrc
export HADOOP_HOME=/home/longpt/hadoop
export PATH=${PATH}:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin

source /home/longpt/.profile

```

## 4. java 

- tìm java

```
update-alternatives --display java
echo ${JAVA_HOME}
```

- k có thì cài 

```
sudo apt-get install openjdk-8-jdk
```

## 5. hadoop 

- trỏ hadoop vào

```
nano ~/hadoop/etc/hadoop/hadoop-env.sh
export JAVA_HOME=${JAVA_HOME}
or 
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre`
```

- master


```
nano  ~/hadoop/etc/hadoop/core-site.xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
    <configuration>
        <property>
            <name>fs.default.name</name>
            <value>hdfs://10.3.107.203:9000</value>
        </property>
    </configuration>
```

- path hdfs

```
nano ~/hadoop/etc/hadoop/hdfs-site.xml

<configuration>
    <property>
            <name>dfs.namenode.name.dir</name>
            <value>/home/longpt/data/nameNode</value>
    </property>

    <property>
            <name>dfs.datanode.data.dir</name>
            <value>/home/longpt/data/dataNode</value>
    </property>

    <property>
            <name>dfs.replication</name>
            <value>1</value>
    </property>
</configuration>


```

- yarn 

```
nano ~/hadoop/etc/hadoop/mapred-site.xml

<configuration>
    <property>
            <name>mapreduce.framework.name</name>
            <value>yarn</value>
    </property>
    <property>
            <name>yarn.app.mapreduce.am.env</name>
            <value>HADOOP_MAPRED_HOME=$HADOOP_HOME</value>
    </property>
    <property>
            <name>mapreduce.map.env</name>
            <value>HADOOP_MAPRED_HOME=$HADOOP_HOME</value>
    </property>
    <property>
            <name>mapreduce.reduce.env</name>
            <value>HADOOP_MAPRED_HOME=$HADOOP_HOME</value>
    </property>
</configuration>
```

- yarn config

```
nano ~/hadoop/etc/hadoop/yarn-site.xml

<configuration>
    <property>
            <name>yarn.acl.enable</name>
            <value>0</value>
    </property>

    <property>
            <name>yarn.resourcemanager.hostname</name>
            <value>10.3.107.203</value>
    </property>

    <property>
            <name>yarn.nodemanager.aux-services</name>
            <value>mapreduce_shuffle</value>
    </property>
</configuration>
```


- worker 

```
nano ~/hadoop/etc/hadoop/workers
10.3.105.61
10.3.105.185
```

## 6. move to worker 

- move
```
scp hadoop-*.tar.gz 10.3.105.61:/home/longpt
scp hadoop-*.tar.gz 10.3.105.185:/home/longpt
```

- ssh to worker unzip 

```
tar -xzf hadoop-3.3.1.tar.gz
mv hadoop-3.3.1 hadoop
```

- chuyen config 

```
scp ~/hadoop/etc/hadoop/* 10.3.105.185:/home/longpt/hadoop/etc/hadoop/;
scp ~/hadoop/etc/hadoop/* 10.3.105.61:/home/longpt/hadoop/etc/hadoop/;
```

## 7. run and check 

```
hdfs namenode -format

> master
jsp 
24883 Jps
24149 SecondaryNameNode
23815 NameNode


> worker 
jps 
4368 DataNode
8921 Jps
```

```
start-yarn.sh
```

## 8 debug

- nodemanger k chạy -> 

```
hadoop namenode -format
Before formatting namenode make sure you delete existing
/hadoop/nodes/namenode and /hadoop/nodes/datanode folders
hadoop namenode -format
start-dfs.sh
start-yarn.sh
```

- hoặc có người khác đang chạy, mem đầy ...














